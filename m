Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62011C4A10
	for <lists+linux-ext4@lfdr.de>; Tue,  5 May 2020 01:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgEDXOO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 May 2020 19:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbgEDXON (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 May 2020 19:14:13 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5EFC061A0E
        for <linux-ext4@vger.kernel.org>; Mon,  4 May 2020 16:14:12 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id v8so1125585wma.0
        for <linux-ext4@vger.kernel.org>; Mon, 04 May 2020 16:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jguk.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vjf7WgHnFjqrI2M6EgHW5U0LAqXJHGgSQ0v8LDtq0J0=;
        b=GyKd9fnlANgdGGxbwt4EI3QXTPFs5qRkbJqztEDlmYLUlxVk/d6zJINBE3TJ7YNvOi
         2H5OD7vDsownrBnCWbqPK/uFRQIpwIy/3eK80Z8krVp4XU8964ujAelObOIAb2nijbF2
         1zmYKzXhrzCzdsNfQAuvRFDMMZzVSuEZq4AGqFiX/c4yhViKWX2Tmlb/UhBhH4AcXFhm
         cRb8zESAFAJtyZmIwl5D7YNadAHWqHnbPsim1DrNGTanl00OActCgDrkhYO48Iivr7Gv
         ozl5Jrm3cPyOdahHm8fsycJtQpv4Xaxi/OJ2kywDq6dt8GSspLh2PzBNtt6sr+ec8/aK
         O7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vjf7WgHnFjqrI2M6EgHW5U0LAqXJHGgSQ0v8LDtq0J0=;
        b=kBU5dq2/sWsizecGZGBgGudemRmUQGljS3C2Vu/vACtZUw6ej+PpzpTmqgSYfSetoA
         Z31Uf3eL9oYLbGxNknyA+7DK/EUnrAq3TRFmh4rLyUNNmMj9LI5YaMTuqJHBi2uCe4sm
         0P+trflyfGB40WKnjl795pdMnVwnuAf09zLMGB/eaehB903vwSEIYJAdBSN/aiz8wvU3
         mb9sHTG9LSKTVjel7t7QXqivoSl4rcNhtgoBP0cQvSBVAIkPuCVl23OUXci7byzkyBIC
         rfD64rNacCF9sGW9iuPDO4bqyfMKxp28QiC+rLDybmwyBDDbcZrXgFKy3hjSziLfWy7Z
         AFug==
X-Gm-Message-State: AGi0PuaDr2LzFGu2JBwf4tOKE1IJP9tWa23BaKgzqVasMfBLb6U4kp2b
        Q0wLXhLVic+8h8vnZJfjJkLhH1LWE08=
X-Google-Smtp-Source: APiQypLpzvcDMa26iIsiLb8Eyytr5C7PuvXunwHK89wwxjt+iohGC7ypDvi89I4F8oDhTPUrn1Qs6w==
X-Received: by 2002:a1c:9852:: with SMTP id a79mr79777wme.27.1588634050822;
        Mon, 04 May 2020 16:14:10 -0700 (PDT)
Received: from [192.168.0.12] (cpc87281-slou4-2-0-cust47.17-4.cable.virginm.net. [92.236.12.48])
        by smtp.gmail.com with ESMTPSA id y3sm1804517wrm.64.2020.05.04.16.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 16:14:10 -0700 (PDT)
Subject: Re: /fs/ext4/ext4.h add a comment to ext4_dir_entry_2
To:     Andreas Dilger <adilger@dilger.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
References: <bf50e54f-2a0c-17a4-89c3-4afcc298daeb@jguk.org>
 <1B91A6E6-7F4A-4C58-93E7-394217C1631C@dilger.ca>
 <20200504223900.GA5691@magnolia>
 <0FC238E1-59D7-448B-BD72-C2794A3BD99E@dilger.ca>
From:   Jonny Grant <jg@jguk.org>
Message-ID: <9ebe9b5b-2809-ce47-91ab-e4e10b8481d2@jguk.org>
Date:   Tue, 5 May 2020 00:14:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0FC238E1-59D7-448B-BD72-C2794A3BD99E@dilger.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 05/05/2020 00:00, Andreas Dilger wrote:
> 
>> On May 4, 2020, at 4:39 PM, Darrick J. Wong <darrick.wong@oracle.com> wrote:
>>
>> On Mon, May 04, 2020 at 04:26:35PM -0600, Andreas Dilger wrote:
>>>
>>>> On May 3, 2020, at 6:52 AM, Jonny Grant <jg@jguk.org> wrote:
>>>>
>>>> Hello
>>>>
>>>> Could a comment be added to clarify 'file_type' ?
>>>>
>>>> struct ext4_dir_entry_2 {
>>>>    __le32    inode;            /* Inode number */
>>>>    __le16    rec_len;        /* Directory entry length */
>>>>    __u8    name_len;        /* Name length */
>>>>    __u8    file_type;
>>>>    char    name[EXT4_NAME_LEN];    /* File name */
>>>> };
>>>>
>>>>
>>>>
>>>> This what I am proposing to add:
>>>>
>>>>    __u8    file_type;        /* See directory file type macros below */
>>>
>>> For this kind of structure field, it makes sense to reference the macro
>>> names directly, like:
>>>
>>> 	__u8	file_type;	/* See EXT4_FT_* type macros below */
>>>
>>> since "macros below" may be ambiguous as the header changes over time.
>>>
>>>
>>> Even better (IMHO) is to use a named enum for this, like:
>>>
>>>         enum ext4_file_type file_type:8; /* See EXT4_FT_ types below */
>>>
>>> /*
>>> * Ext4 directory file types.  Only the low 3 bits are used.  The
>>> * other bits are reserved for now.
>>> */
>>> enum ext4_file_type {
>>> 	EXT4_FT_UNKNOWN		= 0,
>>> 	EXT4_FT_REG_FILE	= 1,
>>> 	EXT4_FT_DIR		= 2,
>>> 	EXT4_FT_CHRDEV		= 3,
>>> 	EXT4_FT_BLKDEV		= 4,
>>> 	EXT4_FT_FIFO		= 5,
>>> 	EXT4_FT_SOCK		= 6,
>>> 	EXT4_FT_SYMLINK		= 7,
>>> 	EXT4_FT_MAX,
>>> 	EXT4_FT_DIR_CSUM	= 0xDE
>>> };
>>>
>>> so that the allowed values for this field are clear from the definition.
>>> However, the use of a fixed-with bitfield (enum :8) is a GCC-ism and Ted
>>> may be against that for portability reasons, since the kernel and
>>> userspace headers should be as similar as possible.
>>
>> This is an on-disk structure.  Do /not/ make this an enum because that
>> would replace a __u8 with an int, which will break directories.
> 
> No, that is what the fixed bitfield declaration "enum ... :8" would do -
> declare this enum to be an 8-bit integer.  I've verified that this works
> as expected with GCC, to allow an enum with a specific size, like :8 or
> :32 or :64.  Obviously, if you specify a bitfield size that doesn't align
> with the start of the next structure field, there would be padding added
> so that the next field is properly aligned, but that isn't the case here.
> 
> Since e2fsprogs needs to be portable to other compilers/OS, I'm not sure
> if Ted would want the kernel header declaration to be different than the
> e2fsprogs header.  I've grown to like using enum for these kind of "flags"
> definitions, since they are much more concrete than a bare "int flags"
> declaration, and still better than "int flags; /* see EXT4_FT_* below */"
> since the enum is a hard compiler linkage vs. just a comment, for the
> same reasons that static inline functions are better than CPP macros.
> 
> Cheers, Andreas

Hi Andreas

Re changing the macros,
how about using the following approach?


const __u8 EXT4_FT_UNKNOWN = 0;
const __u8 EXT4_FT_REG_FILE = 1;
etc

Generally I prefer to avoid macros if I can personally.

Cheers, Jonny

