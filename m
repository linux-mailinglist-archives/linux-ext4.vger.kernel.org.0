Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A2557DF17
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jul 2022 12:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbiGVKD3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Jul 2022 06:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiGVKD2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Jul 2022 06:03:28 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC6A54CAA;
        Fri, 22 Jul 2022 03:03:26 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id f24-20020a1cc918000000b003a30178c022so4856574wmb.3;
        Fri, 22 Jul 2022 03:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TOzciIS0TzruLZ8NbgZbhZhg7hpcQvqlQ1mGol8Oe+0=;
        b=D8PLIJodeUutKzrIt8L2yliEjrea3TCZIiB2q0HV6gqgXIMMtCT3Y/CIr+sy02Jrua
         CTchY0HHGnATyzQrtPapt3Qlej1Kw7u0bqvxVz0TGuuqV1VozIitsMIo5XNibNOQRulw
         ZAd6J/9gBnaNjjMuhaMbWvtbOoHGeVszIcbdrLYYCJ4y5vekRTT74pnqTx+HC5gqRmkc
         PJJcft/B8dVAmcjvkZzdJQkDSklm5n9nCPz4TddDlJN81L50gxt8ZLTmLt/F9TpxBnvE
         U2RExcjtVxVtfsxlGtqc27zOxORuu5cumJ0yxy11HrtfXyJTWmKuNhq3+L64UmLlin4+
         z2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TOzciIS0TzruLZ8NbgZbhZhg7hpcQvqlQ1mGol8Oe+0=;
        b=hs5nyc/ofYfhpo4X1w8bwJkaFJcvN+YXsfOuKEPUv7FSlAw+gxU0HLlovelEik8xiy
         E6qFD/bLanDqwaPanhiXwe5x8qloVsvrpUoeJDc6L0S28gKy0bnJ5XpJyxIf1Ku6q9Ke
         0dT0lAWWZt/GUnrSHQLy2O9Am/Y1zBvW1aYDoBt3qS8e6IKDdwPCHfQ1WEIlscwIOxNT
         n3T9UZHBlovRw6q2KWxbk8xmaE4nMAJcEdBasQ34Lso02BnVfYkVX7MMFl6HrZDIvWxk
         TrN5Vz+wyWFLF9FdbrD1gClf83zk4ZKmU3RLnogglQD4dzEPnBRX2uQMlXCO/9D7OyBi
         WxBw==
X-Gm-Message-State: AJIora+VFBgUYUZqzXj0t/pvnwm4q6QShl5+pjKPJpD8/YsMhoPwjNmB
        /JJtL0cdmBgYz1w2bQ+24FUNhWzhWMw=
X-Google-Smtp-Source: AGRyM1uRolYAQJqcNHoY+9JOUQqMBeab+aw/n/1iFbQUplF0mU5jAjYZUC/AuibIk4iaDOs1Nl4B0A==
X-Received: by 2002:a05:600c:4f06:b0:3a3:2158:c5ed with SMTP id l6-20020a05600c4f0600b003a32158c5edmr2007809wmq.103.1658484205172;
        Fri, 22 Jul 2022 03:03:25 -0700 (PDT)
Received: from [10.168.10.170] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id k1-20020adff5c1000000b0020fff0ea0a3sm3989582wrp.116.2022.07.22.03.03.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 03:03:24 -0700 (PDT)
Message-ID: <e1573002-7ea3-2636-b2d2-331767a5622f@gmail.com>
Date:   Fri, 22 Jul 2022 12:03:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] Add manpage for get/set fsuuid ioctl for ext4
 filesystem.
Content-Language: en-US
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jeremy Bongio <bongiojp@gmail.com>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, linux-man@vger.kernel.org
References: <20220720234512.354076-1-bongiojp@gmail.com>
 <YtiZ+gOmOFTpiAjW@magnolia> <e503645b-e665-50c4-37a9-cdc8637ba1d8@gmail.com>
 <YtmXAyoF2PXstnLY@magnolia>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
In-Reply-To: <YtmXAyoF2PXstnLY@magnolia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Darrick,

On 7/21/22 20:12, Darrick J. Wong wrote:
> On Thu, Jul 21, 2022 at 03:04:23PM +0200, Alejandro Colomar wrote:
>> Hi Jeremy and Darrick,
>>
>> On 7/21/22 02:12, Darrick J. Wong wrote:
>>> On Wed, Jul 20, 2022 at 04:45:12PM -0700, Jeremy Bongio wrote:
>>>> Signed-off-by: Jeremy Bongio <bongiojp@gmail.com>
>>>> ---
>>>>
>>>> This is a ext4 filesystem specific ioctl. However, this ioctl will
>>>> likely be implemented for multiple filesystems at which point this
>>>> manpage will be updated.
>>>>
>>>>    man2/ioctl_fsuuid.2 | 115 ++++++++++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 115 insertions(+)
>>>>    create mode 100644 man2/ioctl_fsuuid.2
>>>>
>>>> diff --git a/man2/ioctl_fsuuid.2 b/man2/ioctl_fsuuid.2
>>>> new file mode 100644
>>>> index 000000000..53747684f
>>>> --- /dev/null
>>>> +++ b/man2/ioctl_fsuuid.2
>>>> @@ -0,0 +1,115 @@
>>>> +.\" Copyright (c) 2022 Google, Inc., written by Jeremy Bongio <bongiojp@gmail.com>
>>>> +.\"
>>>> +.\" SPDX-License-Identifier: Linux-man-pages-copyleft
>>>> +.TH IOCTL_FSUUID 2 2022-07-20 "Linux" "Linux Programmer's Manual"
>>>> +.SH NAME
>>>> +ioctl_fsuuid \- get or set an ext4 filesystem uuid
>>>> +.SH LIBRARY
>>>> +Standard C library
>>>> +.RI ( libc ", " \-lc )
>>>
>>> I'm not sure if libc will actually wrap this one, they often won't do
>>> that for ioctls.
>>
>> Actually, we also specify libc for syscalls without a wrapper (e.g., see
>> membarrier(2)).  That rationale is that you need libc even if you use
>> syscall(SYS_membarrier, ...), since syscall(2) is provided by libc.
>>
>> However, there's a difference in the synopsis:
>> If syscall(2) needs to be used to call the syscall, we document it as such.
>> Again, see membarrier(2) for an example of how we document that.
> 
> I understand that manpages for system calls that don't have a libc
> wrapper document the use of syscall(SYS_fubar...) to call them.  But
> this is an ioctl, not a kernel system call that has no convenient libc
> wrapper.  ioctl(2) has been part of the Unix programming manual since
> 1979 or so, and it's been in Linux since v0.99.  I think we can take for
> granted that programmers can figure out 'man -s2 ioctl' if we tell them
> to.

> 
>>>
>>>> +.SH SYNOPSIS
>>>> +.nf
>>>> +.B #include <sys/ioctl.h>
>>>> +.PP
>>>> +.BI "int ioctl(int " fd ", EXT4_IOC_GETFSUUID, struct " fsuuid ");"
>>>> +.BI "int ioctl(int " fd ", EXT4_IOC_SETFSUUID, struct " fsuuid ");"
>>
>> Can we use ioctl(2), or do we need syscall(SYS_ioctl, ...)?
> 
> So yes, technically an ioctl_XXX manpage should document the fact that
> it depends on the existence of an ioctl(fd, number, param...) call, and
> that in turn depends on syscall(SYS_ioctl, fd, number, param...) if
> somehow ioctl() itself is not available and that in turn depends on
> using any of the usual Linux C libraries, but this seems very pedantic
> to repeat that for every single ioctl manpage in existence.
> 
> IOWS, I think we can take for granted that most C programmers on Linux
> are working with a conventional C library, so it's sufficient to put:
> 
> SEE ALSO
> 	ioctl(2)
> 
> at the end of an ioctl_XXX manpage like this one.
> 

Okay.  Then may I ask for an EXAMPLES section with a program that 
unequivocally shows users how to use it?

>>
>>>> +.fi
>>>> +.SH DESCRIPTION
>>>> +If an ext4 filesystem supports uuid manipulation, these
>>>> +.BR ioctl (2)
>>>> +operations can be used to get or set the uuid for the ext4 filesystem
>>>> +on which
>>>> +.I fd
>>>> +resides.
>>>> +.PP
>>>> +The argument to these operations should be a pointer to a
>>>> +.IR "struct fsuuid" ":"
>>>> +.PP
>>>> +.in +4n
>>>> +.EX
>>>> +struct fsuuid {
>>
>> Would you consider documenting the type separate manual page?
>> See for example man2/open_how.2type and man3/tm.3type.
> 
> Why?  There's only one user of this struct, there's no need to waste
> people's time making them look up the third ioctl argument in a separate
> manpage.  If some other ioctl/syscall/whatever wants to start using
> struct fsuuid then yes, this should be hoisted to a separate file so
> that both manpages can reference it.

I prefer types in separate pages, as the information is organized, and 
also because it allows to `man 2type fsuuid` if you want to see 
information about the type without knowing what the type is for (e.g., 
you've seen the type in some random code, maybe far from its 
corresponding ioctl(2) use, and want to understand it).

But `man fsuuid` can also be accomplished if we add a link page (see 
e.g. int8_t.3type for how to do it), if you prefer that.

Thanks,

Alex

> 
>>>> +       __u32 fsu_len;      /* Number of bytes in a uuid */
>>>> +       __u32 fsu_flags;    /* Mapping flags */
>>>> +       __u8  fsu_uuid[];   /* Byte array for uuid */
>>
>> We use 4-space indents for code.
>>
>>>> +};
>>>> +.EE
>>>> +.PP
>>>> +The
>>>> +.I fsu_flags
>>>> +field must be set to 0.
>>>
>>> Nit: whitespace at the end of the line.
>>>
>>>> +.PP
>>>> +If an
>>>> +.BR EXT4_IOC_GETFSUUID
>>>> +operation is called with
>>>> +.I fsu_len
>>>> +set to 0,
>>>> +.I fsu_len
>>>> +will be reassigned the number of bytes in an ext4 filesystem uuid
>>>
>>> "...will be set to the number of bytes..." ?
>>>
>>>> +and the return code will be -EINVAL.
>>>> +.PP
>>>> +If an
>>>> +.BR EXT4_IOC_GETFSUUID
>>>> +operation is called with
>>>> +.I fsu_len
>>>> +set to the number of bytes in an ext4 filesystem uuid and
>>>> +.I fsu_uuid
>>>> +is allocated at least that many bytes, then
>>>> +the filesystem uuid will be written to
>>>> +.I fsu_uuid.
>>>
>>> Hm.  It's not like the kernel actually checks the allocation -- if
>>> fsu_len is set to the length of the filesystem's volume uuid, then
>>> the that volume uuid will be written to fsu_uuid[].  How about:
>>>
>>> "If EXT4_IOC_GETFSUUID is called with fsu_len matching the length of the
>>> ext4 filesystem uuid, then that uuid will be written to fsu_uuid[] and
>>> the return value will be zero.
>>> If fsu_len does not match, the return value will be -EINVAL."
>>>
>>>> +.PP
>>>> +If an
>>>> +.BR EXT4_IOC_SETFSUUID
>>>> +operation is called with
>>>> +.I fsu_len
>>>> +set to the number of bytes in an ext4 filesystem uuid and
>>>> +.I fsu_uuid
>>>> +contains a uuid with
>>>
>>> Nit: whitespace at EOL.
>>>
>>>> +.I fsu_uuid
>>>> +bytes, then
>>>> +the filesystem uuid will be set to
>>>> +.I fsu_uuid.
>>>
>>> "If EXT4_IOC_SETFSUUID is called with fsu_len matching the length of the
>>> ext4 filesystem uuid, then the filesystem uuid will be set to the
>>> contents of fsu_uuid[] and the return value will reflect the outcome of
>>> the update operation.
>>> If fsu_len does not match, the return value will be -EINVAL."
>>>
>>>> +.PP
>>>> +The
>>>> +.B FS_IOC_SETFSUUID
>>>> +operation requires privilege
>>>> +.RB ( CAP_SYS_ADMIN ).
>>>> +If the filesystem is currently being resized, an
>>>> +.B EXT4_IOC_SETFSUUID
>>>> +operation will wait until the resize is finished and the uuid can safely be set.
>>>> +This may take a long time.
>>>
>>> Why is resize called out here specifically?  Won't setfsuuid block on
>>> /any/ operation that has tied up the filesystem superblocks?  I think
>>> this could be more general:
>>>
>>> "If the filesystem is busy, an EXT4_IOC_SETFSUUID operation will wait
>>> until it can apply the uuid changes.
>>> This may take a long time."
>>>
>>>> +.PP
>>>> +.SH RETURN VALUE
>>>> +On success zero is returned.
>>>> +On error, \-1 is returned, and
>>>> +.I errno
>>>> +is set to indicate the error.
>>>> +.SH ERRORS
>>>> +Possible errors include (but are not limited to) the following:
>>>> +.TP
>>>> +.B EFAULT
>>>> +Either the pointer to the
>>>> +.I fsuuid
>>>> +structure is invalid or
>>>> +.I fsu_uuid
>>>> +has not been initialized properly.
>>>
>>> Invalid?  Isn't that what EINVAL is for?
>>>
>>> I think EFAULT is for "could not copy to/from userspace".
>>>
>>>> +.TP
>>>> +.B EINVAL
>>>> +The specified arguments are invalid.
>>>> +.I fsu_len
>>>> +did not match the filesystem uuid length or
>>>> +.I fsu_flags
>>>> +has bits set that are not implemented.
>>>
>>> "...not recognized."
>>>
>>> If they're not implemented, shouldn't that be EOPNOTSUPP?
>>>
>>> --D
>>>
>>>> +.TP
>>>> +.B ENOTTY
>>>> +The filesystem does not support the ioctl.
>>>> +.TP
>>>> +.B EOPNOTSUPP
>>>> +The filesystem does not currently support changing the uuid through this
>>>> +ioctl. This may be due to incompatible feature flags.
>>
>> Please see the following paragraph from man-pages(7):
>>     Use semantic newlines
>>         In the source of a manual page, new sentences  should  be
>>         started on new lines, long sentences should be split into
>>         lines  at  clause breaks (commas, semicolons, colons, and
>>         so on), and long clauses should be split at phrase bound‐
>>         aries.  This convention,  sometimes  known  as  "semantic
>>         newlines",  makes it easier to see the effect of patches,
>>         which often operate at the level of individual sentences,
>>         clauses, or phrases.
> 
> Agreed.
> 
> --D
> 
>>
>> Cheers,
>>
>> Alex
>>
>>
>>>> +.TP
>>>> +.B EPERM
>>>> +The calling process does not have sufficient permissions to set the uuid.
>>>> +.SH CONFORMING TO
>>>> +This API is Linux-specific.
>>>> +.SH SEE ALSO
>>>> +.BR ioctl (2)
>>>> -- 
>>>> 2.37.0.170.g444d1eabd0-goog
>>>>

-- 
Alejandro Colomar
Linux man-pages comaintainer; http://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
