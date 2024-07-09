#!/usr/bin/env bash

script_directory=$(dirname -- ${BASH_SOURCE[0]})

load_question() {
    local contents
    local number_questions
    local question_index
    local question_content

    contents=$(cat "${script_directory}/trivia-question.json")
    number_questions=$(echo "${contents}" | jq '.results | length')
    (( question_index = RANDOM % number_questions))

    # get question content
    question_content=$(echo "${contents}" | jq ".results[${question_index}]")

    # get raw question only
    echo "${question_content}" | jq -r '.question'
    # get correct_answer
    echo "${question_content}" | jq -r '.correct_answer'
    # get incorrect_answer
    echo "${question_content}" | jq -r '.incorrect_answers[0]'
    echo "${question_content}" | jq -r '.incorrect_answers[1]'
    echo "${question_content}" | jq -r '.incorrect_answers[2]'

}

ask_question() {
    local question=${1}
    local correct_answer=${2}
    local incorrect_answer_0=${3}
    local incorrect_answer_1=${4}
    local incorrect_answer_2=${5}

    echo -e "${question}"

    random_answer=$(echo -e "${correct_answer}" "${incorrect_answer_0}" "${incorrect_answer_1}" "${incorrect_answer_2}" | sort -R)

    select answer in $random_answer; do
        if [[ "${answer}" == "${correct_answer}" ]]; then
            echo "the correct answer!"
            return 0
        else
            echo "the Incorrect answer!"
            # return 1
        fi
    done
}

main () {
    local question
    local correct_answer
    local incorrect_answer_0
    local incorrect_answer_1
    local incorrect_answer_2

    # read multiple data
    {
        read -r question
        read -r correct_answer
        read -r incorrect_answer_0
        read -r incorrect_answer_1
        read -r incorrect_answer_2
    } < <(load_question)

    ask_question "${question}" \
                 "${correct_answer}" \
                 "${incorrect_answer_0}" \
                 "${incorrect_answer_1}" \
                 "${incorrect_answer_2}"
}

# "$@" meaning: when args are passed into the bash script file, it will be passed into main function
main "$@"