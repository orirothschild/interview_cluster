def reverse_word(wrd):
    new_word = []
    index = len(wrd)
    for i in range(0,index,1):
        new_word.append(wrd[index-1-i])
    new_word.append(' ')
    return ''.join(new_word)

def reverse_string(str):
    new_string = map(reverse_word,str.split())
    return ''.join(new_string)

if __name__ == "__main__":
    str = "hello this is world"
    print(''.join(reverse_string(str)))