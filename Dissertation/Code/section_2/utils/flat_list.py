def flat_list(nestedList):
    ''' Converts a nested list to a flat list '''
    flatList = []
    # Iterate over all the elements in given list
    for elem in nestedList:
        # Check if type of element is list
        if isinstance(elem, list):
            # Extend the flat list by adding contents of this element (list)
            flatList.extend(flat_list(elem))
        elif isinstance(elem, dict):
            for v in elem.values():
                flatList.append(v)
        else:
            # Append the elemengt to the list
            flatList.append(elem)

    return flatList
