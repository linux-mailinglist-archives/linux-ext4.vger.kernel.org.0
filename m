Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C438401D36
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Sep 2021 16:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243510AbhIFOmv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Sep 2021 10:42:51 -0400
Received: from smtp3-1.goneo.de ([85.220.129.38]:57317 "EHLO smtp3-1.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238717AbhIFOmu (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 6 Sep 2021 10:42:50 -0400
Received: from [192.168.1.127] (dyndsl-091-096-160-132.ewe-ip-backbone.de [91.96.160.132])
        by smtp3.goneo.de (Postfix) with ESMTPSA id 2C534203E929;
        Mon,  6 Sep 2021 16:41:44 +0200 (CEST)
Subject: Re: [PATCH 1/2] ext4: docs: switch away from list-table
To:     Jonathan Corbet <corbet@lwn.net>, Akira Yokosawa <akiyks@gmail.com>
Cc:     jack@suse.cz, linux-doc@vger.kernel.org,
        linux-ext4@vger.kernel.org, tytso@mit.edu,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20210902220854.198850-2-corbet@lwn.net>
 <b1909f4c-9e07-abd7-89ee-c2e551f9dc5b@gmail.com>
 <871r65zobl.fsf@meer.lwn.net>
 <a93af4a2-9b9f-6430-bc3a-dfb2dbf7e56b@gmail.com>
 <68ae637d-dc8d-cedc-b058-8f4ebb146137@darmarit.de>
 <87lf49wzyz.fsf@meer.lwn.net>
From:   Markus Heiser <markus.heiser@darmarit.de>
Message-ID: <5f3f3e53-0a52-8f87-8bb7-e1cca5c0ccdb@darmarit.de>
Date:   Mon, 6 Sep 2021 16:41:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87lf49wzyz.fsf@meer.lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Am 06.09.21 um 16:17 schrieb Jonathan Corbet:
> Markus Heiser <markus.heiser@darmarit.de> writes:
> 
>> We prefer list tables ...
>>
>> """Their advantage is that they are easy to create or modify and that the
>> diff of a modification is much more meaningful, because it is limited to
>> the modified content."""
>>
>> By example: We have some very large tables with tons of rows and cols.
>> If you need to extend one column just by one character you have to edit
>> the whole table and the diff is not readable.
>>
>> It is not limited to big tables, e.g. if you patch a simple typo,
>> you might need touch content not related to your fix.
>>
>> At the end it is a trade of, what weights more, readability of the
>> plain text or readability of the patch / most often I would vote
>> for the latter.
> 
> If the documentation is of any use of all there will be a lot more
> people reading it than will be reading patches making tweaks to it.
> Optimizing for patch readability seems like the wrong focus to me.
> 
> The ext4 folks can decide what they like best in this specific case.
> But I think that the advice in favor of list tables is wrong in the
> general case; they are completely unreadable in their source form, and
> that goes against one of the key reasons we adopted RST in the first
> place.
> 
> Somebody will surely try to add a list table to the wrong document
> someday and I'll get to live through another one of those nifty
> explosions - and I'll have neither reasons nor motivation to defend that
> policy.

I do not see a problem changing the policy to use pre-formated tables.

@jon do you like to fix the "list tables" section of doc-guide/sphinx.rst

Thanks,

Markus
