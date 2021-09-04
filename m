Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42F8400A4F
	for <lists+linux-ext4@lfdr.de>; Sat,  4 Sep 2021 09:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbhIDHvb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 4 Sep 2021 03:51:31 -0400
Received: from smtp3-1.goneo.de ([85.220.129.38]:46960 "EHLO smtp3-1.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233068AbhIDHvb (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 4 Sep 2021 03:51:31 -0400
X-Greylist: delayed 309 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Sep 2021 03:51:30 EDT
Received: from [192.168.1.107] (dyndsl-085-016-043-081.ewe-ip-backbone.de [85.16.43.81])
        by smtp3.goneo.de (Postfix) with ESMTPSA id 4A8E82040DA4;
        Sat,  4 Sep 2021 09:45:18 +0200 (CEST)
Subject: Re: [PATCH 1/2] ext4: docs: switch away from list-table
To:     Akira Yokosawa <akiyks@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc:     jack@suse.cz, linux-doc@vger.kernel.org,
        linux-ext4@vger.kernel.org, tytso@mit.edu,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20210902220854.198850-2-corbet@lwn.net>
 <b1909f4c-9e07-abd7-89ee-c2e551f9dc5b@gmail.com>
 <871r65zobl.fsf@meer.lwn.net>
 <a93af4a2-9b9f-6430-bc3a-dfb2dbf7e56b@gmail.com>
From:   Markus Heiser <markus.heiser@darmarit.de>
Message-ID: <68ae637d-dc8d-cedc-b058-8f4ebb146137@darmarit.de>
Date:   Sat, 4 Sep 2021 09:45:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <a93af4a2-9b9f-6430-bc3a-dfb2dbf7e56b@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Am 04.09.21 um 03:23 schrieb Akira Yokosawa:
> On Fri, 03 Sep 2021 09:11:26 -0600, Jonathan Corbet wrote:
>> Akira Yokosawa <akiyks@gmail.com> writes:
>>
>> [Adding Mauro]
>>
>>> On Thu,  2 Sep 2021 16:08:53 -0600, Jonathan Corbet wrote:
>>>
>>>> Commit 3a6541e97c03 (Add documentation about the orphan file feature) added
>>>> a new document on orphan files, which is great.  But the use of
>>>> "list-table" results in documents that are absolutely unreadable in their
>>>> plain-text form.  Switch this file to the regular RST table format instead;
>>>> the rendered (HTML) output is identical.
>>>
>>> In the "list tables" section of doc-guide/sphinx.rst, the first paragraph
>>> starts with the sentence:
>>>
>>>      We recommend the use of list table formats.
>>>
>>> Yes, the disadvantage of list tables is mentioned later in the paragraph:
>>>
>>>      Compared to the ASCII-art they might not be as comfortable for readers
>>>      of the text files.
>>>
>>> , but I still see list-table is meant as the preferred format.
>>
>> Interesting...that is not at all my memory of the discussions we had at
>> that time.  There was a lot of pushback against anything that makes the
>> RST files less readable - still is, if certain people join the
>> conversation.  Tables were one of the early flash points.
>>
>> Mauro, you added that text; do you remember things differently?  Do you
>> feel we should retain that recommendation?
> 
> No, the text was first added by Markus Heiser [added to CC] in commit
> 0249a7644857 ("doc-rst: flat-table directive - initial implementation")
> and have not updated ever since.
> 
> He might remember the circumstances, but 2016 was a long time ago,
> I guess.

We prefer list tables ...

"""Their advantage is that they are easy to create or modify and that the
diff of a modification is much more meaningful, because it is limited to
the modified content."""

By example: We have some very large tables with tons of rows and cols.
If you need to extend one column just by one character you have to edit
the whole table and the diff is not readable.

It is not limited to big tables, e.g. if you patch a simple typo,
you might need touch content not related to your fix.

At the end it is a trade of, what weights more, readability of the
plain text or readability of the patch / most often I would vote
for the latter.

  -- Markus --


> 
> Or did the discussions take place after the list table support had been
> added?
> 
>          Thanks, Akira (a newcomer to kerneldoc)
> 
>>
>> Thanks,
>>
>> jon
>>
