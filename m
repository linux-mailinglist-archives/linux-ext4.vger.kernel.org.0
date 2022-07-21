Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1290157CB55
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Jul 2022 15:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbiGUNFt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Jul 2022 09:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233937AbiGUNFd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Jul 2022 09:05:33 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6EC86888;
        Thu, 21 Jul 2022 06:04:27 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h9so2221174wrm.0;
        Thu, 21 Jul 2022 06:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HM/2yDkiUzm/nm8ARsJ+710GiW/0usRzfLrjCBZ+q5M=;
        b=E2Z31Svpd5o8C3sO6c9DJ2WB0jUOfwYd1iwN8mTkFXjQbbvlE+ZXPKzagOIB3VtaKn
         Z+chyL0Jswot/p+gFpG6Qxr+0l4sUr6tUBxMBksG0p1ymSY4wQLxCk5jvkKtOeBFK8hr
         RpTiBA9ngHNxrzP5goZM1U3EzYKRTKok853PighXUEoVgKMiYwaAT8GXNhSTRJ0UZG8x
         F6p3n6/J2j3uYwLm8GLyUYJeMWbiM5lSPEkjhtpoj8K9/KhERjeVci3zFPNaRvgSpf5y
         GaSGAE7vORkJQ4SrP2/DkflP5wc23tbiFdeFobF40m5HK5rjsjAKcVXg13NcyurLB6Tx
         yvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HM/2yDkiUzm/nm8ARsJ+710GiW/0usRzfLrjCBZ+q5M=;
        b=P5vsgfdQSqRq19fXb7qEDZvu82BuUtP6Sd+eP9H3rp3mKBC2fm7kANnhRBM/dOa1UC
         o68ZQAB+EsgJRevC+xBBLv+XbGp8ae+aPaJnnB2vglRL3OAORMbtwL49fiSwx1olNufJ
         gJWNaBaIhthvaLUJ+gWEcwO1GHMLSRT2i5/G9REZoIlQl/jfHLp3JyoaD9GgyPdTk2gk
         LWeiky94LRFWHjpzMNiYxB161WOSlBauC+0M7S8wzVwpEF9PL67+AEJrjWVxXYwhRZwW
         NiltdlaVMEl9YmgOAHjCjRhZfnnBefq4kTE/3vN/PSxc2ka/ci/j9Y+IndEKBR/vm1bZ
         BTBQ==
X-Gm-Message-State: AJIora8HVWBwJ3KqNVnTS8ciEMU9v6nOKfjkDcXf5rTGRgtCJIb/8tpr
        tuM2NBMRJgiG1r4xpa04sMI=
X-Google-Smtp-Source: AGRyM1sGTruxUd+ggKgNLZy5vzF5yjLNSXQnPBdKO0k1UilttK4mR2FWRcOdhy6ZOWEBhKaNfIQ5XA==
X-Received: by 2002:a05:6000:1549:b0:21d:bdce:1d01 with SMTP id 9-20020a056000154900b0021dbdce1d01mr35147418wry.373.1658408665266;
        Thu, 21 Jul 2022 06:04:25 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c268900b003a31ca9dfb6sm2226887wmt.32.2022.07.21.06.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 06:04:24 -0700 (PDT)
Sender: Alejandro Colomar <alx.mailinglists@gmail.com>
Message-ID: <e503645b-e665-50c4-37a9-cdc8637ba1d8@gmail.com>
Date:   Thu, 21 Jul 2022 15:04:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH v2] Add manpage for get/set fsuuid ioctl for ext4
 filesystem.
Content-Language: en-US
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Jeremy Bongio <bongiojp@gmail.com>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-man@vger.kernel.org
References: <20220720234512.354076-1-bongiojp@gmail.com>
 <YtiZ+gOmOFTpiAjW@magnolia>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <YtiZ+gOmOFTpiAjW@magnolia>
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

Hi Jeremy and Darrick,

On 7/21/22 02:12, Darrick J. Wong wrote:
> On Wed, Jul 20, 2022 at 04:45:12PM -0700, Jeremy Bongio wrote:
>> Signed-off-by: Jeremy Bongio <bongiojp@gmail.com>
>> ---
>>
>> This is a ext4 filesystem specific ioctl. However, this ioctl will
>> likely be implemented for multiple filesystems at which point this
>> manpage will be updated.
>>
>>   man2/ioctl_fsuuid.2 | 115 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 115 insertions(+)
>>   create mode 100644 man2/ioctl_fsuuid.2
>>
>> diff --git a/man2/ioctl_fsuuid.2 b/man2/ioctl_fsuuid.2
>> new file mode 100644
>> index 000000000..53747684f
>> --- /dev/null
>> +++ b/man2/ioctl_fsuuid.2
>> @@ -0,0 +1,115 @@
>> +.\" Copyright (c) 2022 Google, Inc., written by Jeremy Bongio <bongiojp@gmail.com>
>> +.\"
>> +.\" SPDX-License-Identifier: Linux-man-pages-copyleft
>> +.TH IOCTL_FSUUID 2 2022-07-20 "Linux" "Linux Programmer's Manual"
>> +.SH NAME
>> +ioctl_fsuuid \- get or set an ext4 filesystem uuid
>> +.SH LIBRARY
>> +Standard C library
>> +.RI ( libc ", " \-lc )
> 
> I'm not sure if libc will actually wrap this one, they often won't do
> that for ioctls.

Actually, we also specify libc for syscalls without a wrapper (e.g., see 
membarrier(2)).  That rationale is that you need libc even if you use 
syscall(SYS_membarrier, ...), since syscall(2) is provided by libc.

However, there's a difference in the synopsis:
If syscall(2) needs to be used to call the syscall, we document it as 
such.  Again, see membarrier(2) for an example of how we document that.

> 
>> +.SH SYNOPSIS
>> +.nf
>> +.B #include <sys/ioctl.h>
>> +.PP
>> +.BI "int ioctl(int " fd ", EXT4_IOC_GETFSUUID, struct " fsuuid ");"
>> +.BI "int ioctl(int " fd ", EXT4_IOC_SETFSUUID, struct " fsuuid ");"

Can we use ioctl(2), or do we need syscall(SYS_ioctl, ...)?

>> +.fi
>> +.SH DESCRIPTION
>> +If an ext4 filesystem supports uuid manipulation, these
>> +.BR ioctl (2)
>> +operations can be used to get or set the uuid for the ext4 filesystem
>> +on which
>> +.I fd
>> +resides.
>> +.PP
>> +The argument to these operations should be a pointer to a
>> +.IR "struct fsuuid" ":"
>> +.PP
>> +.in +4n
>> +.EX
>> +struct fsuuid {

Would you consider documenting the type separate manual page?
See for example man2/open_how.2type and man3/tm.3type.

>> +       __u32 fsu_len;      /* Number of bytes in a uuid */
>> +       __u32 fsu_flags;    /* Mapping flags */
>> +       __u8  fsu_uuid[];   /* Byte array for uuid */

We use 4-space indents for code.

>> +};
>> +.EE
>> +.PP
>> +The
>> +.I fsu_flags
>> +field must be set to 0.
> 
> Nit: whitespace at the end of the line.
> 
>> +.PP
>> +If an
>> +.BR EXT4_IOC_GETFSUUID
>> +operation is called with
>> +.I fsu_len
>> +set to 0,
>> +.I fsu_len
>> +will be reassigned the number of bytes in an ext4 filesystem uuid
> 
> "...will be set to the number of bytes..." ?
> 
>> +and the return code will be -EINVAL.
>> +.PP
>> +If an
>> +.BR EXT4_IOC_GETFSUUID
>> +operation is called with
>> +.I fsu_len
>> +set to the number of bytes in an ext4 filesystem uuid and
>> +.I fsu_uuid
>> +is allocated at least that many bytes, then
>> +the filesystem uuid will be written to
>> +.I fsu_uuid.
> 
> Hm.  It's not like the kernel actually checks the allocation -- if
> fsu_len is set to the length of the filesystem's volume uuid, then
> the that volume uuid will be written to fsu_uuid[].  How about:
> 
> "If EXT4_IOC_GETFSUUID is called with fsu_len matching the length of the
> ext4 filesystem uuid, then that uuid will be written to fsu_uuid[] and
> the return value will be zero.
> If fsu_len does not match, the return value will be -EINVAL."
> 
>> +.PP
>> +If an
>> +.BR EXT4_IOC_SETFSUUID
>> +operation is called with
>> +.I fsu_len
>> +set to the number of bytes in an ext4 filesystem uuid and
>> +.I fsu_uuid
>> +contains a uuid with
> 
> Nit: whitespace at EOL.
> 
>> +.I fsu_uuid
>> +bytes, then
>> +the filesystem uuid will be set to
>> +.I fsu_uuid.
> 
> "If EXT4_IOC_SETFSUUID is called with fsu_len matching the length of the
> ext4 filesystem uuid, then the filesystem uuid will be set to the
> contents of fsu_uuid[] and the return value will reflect the outcome of
> the update operation.
> If fsu_len does not match, the return value will be -EINVAL."
> 
>> +.PP
>> +The
>> +.B FS_IOC_SETFSUUID
>> +operation requires privilege
>> +.RB ( CAP_SYS_ADMIN ).
>> +If the filesystem is currently being resized, an
>> +.B EXT4_IOC_SETFSUUID
>> +operation will wait until the resize is finished and the uuid can safely be set.
>> +This may take a long time.
> 
> Why is resize called out here specifically?  Won't setfsuuid block on
> /any/ operation that has tied up the filesystem superblocks?  I think
> this could be more general:
> 
> "If the filesystem is busy, an EXT4_IOC_SETFSUUID operation will wait
> until it can apply the uuid changes.
> This may take a long time."
> 
>> +.PP
>> +.SH RETURN VALUE
>> +On success zero is returned.
>> +On error, \-1 is returned, and
>> +.I errno
>> +is set to indicate the error.
>> +.SH ERRORS
>> +Possible errors include (but are not limited to) the following:
>> +.TP
>> +.B EFAULT
>> +Either the pointer to the
>> +.I fsuuid
>> +structure is invalid or
>> +.I fsu_uuid
>> +has not been initialized properly.
> 
> Invalid?  Isn't that what EINVAL is for?
> 
> I think EFAULT is for "could not copy to/from userspace".
> 
>> +.TP
>> +.B EINVAL
>> +The specified arguments are invalid.
>> +.I fsu_len
>> +did not match the filesystem uuid length or
>> +.I fsu_flags
>> +has bits set that are not implemented.
> 
> "...not recognized."
> 
> If they're not implemented, shouldn't that be EOPNOTSUPP?
> 
> --D
> 
>> +.TP
>> +.B ENOTTY
>> +The filesystem does not support the ioctl.
>> +.TP
>> +.B EOPNOTSUPP
>> +The filesystem does not currently support changing the uuid through this
>> +ioctl. This may be due to incompatible feature flags.

Please see the following paragraph from man-pages(7):
    Use semantic newlines
        In the source of a manual page, new sentences  should  be
        started on new lines, long sentences should be split into
        lines  at  clause breaks (commas, semicolons, colons, and
        so on), and long clauses should be split at phrase bound‐
        aries.  This convention,  sometimes  known  as  "semantic
        newlines",  makes it easier to see the effect of patches,
        which often operate at the level of individual sentences,
        clauses, or phrases.

Cheers,

Alex


>> +.TP
>> +.B EPERM
>> +The calling process does not have sufficient permissions to set the uuid.
>> +.SH CONFORMING TO
>> +This API is Linux-specific.
>> +.SH SEE ALSO
>> +.BR ioctl (2)
>> -- 
>> 2.37.0.170.g444d1eabd0-goog
>>
