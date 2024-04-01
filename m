Return-Path: <linux-ext4+bounces-1807-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFF089429E
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Apr 2024 18:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F39E1C21DA2
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Apr 2024 16:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DB4481D1;
	Mon,  1 Apr 2024 16:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgjCCtEH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB86340876
	for <linux-ext4@vger.kernel.org>; Mon,  1 Apr 2024 16:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990458; cv=none; b=bCRJR03oDHJugWMbHMjigeQIlaJvYKwnWI9WQMx5y7O2wPKNMrO5uy8Sx/5vul0GQOIgE0I+WIOvof8ghYw/5JXB5IE1z+MOc+o32v7QXcP4qXy0V24BT5LnmzGHx3HXihl2gIx0iOOyUAPws5LVayCYXTbjvzc4Usq4X0nmIt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990458; c=relaxed/simple;
	bh=QLTiEQJr39IsJ/FiZGXezMsTuhj4pjP3wWx6s2/+4FI=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YWcRC7dVRIbUyWJ4nD1GuPuO249P/yqjcNypsKYyU34cgx6R/SxsfbCxvGMfjPtfvC5D21uy7+DRS5LMUkkhIFqYtceDka28F5++qqZdjShckcf1Ue9QLTY1Nf9XigXyqaSwAVMjXgUQeeyeQTLtYG7HwuJeAgCaKxbORmfXIMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgjCCtEH; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6990deb60bfso1246026d6.0
        for <linux-ext4@vger.kernel.org>; Mon, 01 Apr 2024 09:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711990456; x=1712595256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybhi4jaHijQngTMm4QlwojYi/3qBYJnAzGp4n70iaag=;
        b=hgjCCtEHB/FHIqQjA/KKwECIPDjLdWmgpW0BT1bkiGi6mgcd4M76KCujjkb2YbSzDj
         CFrgZEX9GylGzoWRI8Gk/qrnlv35555uMS9ojk0iYXdepOiutzrQSoqC7bCYFXDxX8os
         r7+NfnS46GdDmbhTG4brR+dfqGBgUz/Eb9bxjGnsutnE74dEt86QP9F0AaEANIZD8I9z
         HfZVCAwhGI3MbgwlIYx2h1nn6oJ0yT7JKHtso+RIayEptJL2vD1uBCn+4ym+M4Nhzs9S
         zAfUQcPXmCTYTVJvKA+CZHSKSVo6+GWp7hGZt9VJ6UBQBINSKEnJx0ZQeRBljO+DVEZY
         FJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711990456; x=1712595256;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:to:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ybhi4jaHijQngTMm4QlwojYi/3qBYJnAzGp4n70iaag=;
        b=L9XAfWkxP7PG9vGe9+hGjdiw0Law8sA6K6i3BIYw3lShwYxErd6vdGL4SKHxhZGs2N
         RpkB/Dn8HfXIFBFLFuYuaD/WWe1QRX5EMM5kbRDELvi1eZcHhjmwdt/v3NAkI7AzrjcM
         s5QKeq9NEVb2N6xChNmmzgh0bvBfJ/BqGRiHm1sNGAmKLgC/GU0BGOTZWqJjQ4JEh3s5
         AhWZWa2rnRpCuDE9up4uN++1Uchut5GW3bS92rhXzeM+5I1wD+AwFPNAmfLmDtSJ55BS
         akdXAKR17mMQqPNgM525Ga0Vvd9q2BHIZLD/yl34oJj1245j6z+sH3e8ZD1rECQRIGpO
         SYDg==
X-Gm-Message-State: AOJu0YxfvP3ip9d5q4yOBy5IS+YgLEdHZcnvV4L2cSSyEkkCxRyRbC2c
	1utPnlIgnfwKmJcdSGEYJxGrNghZbJP+B30xlxV087sgz0Ueq+bJFJ+RFsi5TNs=
X-Google-Smtp-Source: AGHT+IHiWq2AkPSum9phcJ75FdBIh2moDnPWCbESRne3+KsLwPMZtxZJ+r/RMZtG9n7f/ZJZf3IrEQ==
X-Received: by 2002:ad4:4b2c:0:b0:696:7b38:cfce with SMTP id s12-20020ad44b2c000000b006967b38cfcemr9904223qvw.48.1711990455702;
        Mon, 01 Apr 2024 09:54:15 -0700 (PDT)
Received: from [192.168.0.41] (97-116-107-164.mpls.qwest.net. [97.116.107.164])
        by smtp.gmail.com with ESMTPSA id jt12-20020a05621427ec00b00696766401adsm4683056qvb.38.2024.04.01.09.54.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Apr 2024 09:54:15 -0700 (PDT)
Subject: Re: noacl and nouser_xattr
To: linux-ext4@vger.kernel.org
References: <528A2397.8030402@me.umn.edu> <528A5CFC.1060706@redhat.com>
From: Paul Markfort <paulfm.mn@gmail.com>
Message-ID: <2291ff18-9aaf-4b2a-023c-cf3abcef5a70@gmail.com>
Date: Mon, 1 Apr 2024 11:54:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101
 Firefox/119.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <528A5CFC.1060706@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit


It took long enough to remove these options - I finally ran into it in 6.4.0 (still was working in the previous kernel I was using: 5.14).  If I had not remembered that they were going to be removed someday, I would have never figured out how to fix the updated system so it would boot properly (no error messages that I could see mentioned acls nor user_xattr options).

Also, the man page for ext(2,3,4) still insists these options are valid.
The man page lists itself as:
E2fsprogs version 1.47.0                    February 2023                                    EXT4(5)

The options themselves should be recognized (but ignored) so they are not a serious error (they should report a WARNING when used - both noacl and acl options should report a WARNING that they are ignored, and that acl is assumed).
This should be the case with ANY option that is no longer supported (warning, but ignored).

Additionally, mount should report their state when you query the mount options (on any FS that always supports acl and user_xattr),
particularly when one uses: mount -v
Besides helping the person who is trying to turn them off notice that they are still on, it will also let people who expect them to be on verify that they are on.

Personally, I still would want the option of mounting a local filesystem noacl (which I can effectively do with ZFS).
And I have seen many posts online of others who want that option.  But I understand if it is to complicated to give admins a way to turn it on and off.


quote from the ext4 man page:
Mount options for ext4
        The ext4 file system is an advanced level of the ext3 file system which  incorporates  scala-
        bility and reliability enhancements for supporting large file system.

        The  options  journal_dev,  journal_path,  norecovery, noload, data, commit, orlov, oldalloc,
        [no]user_xattr, [no]acl, bsddf, minixdf, debug, errors, data_err, grpid, bsdgroups,  nogrpid,
        sysvgroups,  resgid,  resuid, sb, quota, noquota, nouid32, grpquota, usrquota, usrjquota, gr-
        pjquota, and jqfmt are backwardly compatible with ext3 or ext2.



Note about paulfm@me.umn.edu:  paulfm@me.umn.edu went away as a valid email address, several years ago.
please contact me at the email this was sent from (if there are any old questions that bounced, you can send them to me).


On 2013-11-18 12:31 PM, Eric Sandeen wrote:
> On 11/18/13, 8:26 AM, Paul FM wrote:
>>
>> Yes - I need noacl and nouser_xattr
>>
>> How about documenting your intent to remove them in the man pages.
>>
>> acl support and user_xattr support need to be off on the / and /usr
>> filesystems to simplify security. Actually I want a way to turn off
>> ALL extended attribute support on any filesystem.  How about noxattr
>> (which would turn off ALL extended attribute support including acls).
>> I also use nosuid on filesystems that shouldn't have any suid files.
>>
>> This is to follow the security principal - "If you aren't using it
>> and don't need it - turn it off".
> 
> FWIW, it still can be disabled at build time via CONFIG_EXT3_FS_POSIX_ACL
> 
> But if you are using a distro kernel that turns that on, I see
> your point about noacl.
> 
> However, I'm not sure how nouser_xattr comes into the argument?
> xattrs by themselves are just metadata; they don't impact security
> control unless they are a special kind of xattrs (i.e. acls).
> 
> Thanks,
> -Eric
> 
>> The simple Posix/Unix permissions are more than enough security
>> control in almost every situation I have run into (only wish I could
>> use them in Windows).
>>
>> Having worked extensively with ACLS on Windows (and some older Main
>> Frame OSes) - I note that ACL's add a level of complexity to security
>> that actually makes for less security.  I see the need to support
>> them in Unix/Linux - but they should be OFF unless someone
>> specifically wants to use them (at least don't make them hard to turn
>> off).
>>
>> Just try auditing the security of a windows filesystem if you don't
>> think ACL's add extreme complexity (I gave up - I just forcibily set
>> all the ACL's myself by script using the unix Owner,Group,Other
>> concepts as a model to simplify what I am setting).
>>
>>
>>
>>
> 
> 

-- 
--------------------------------------------------------
The views and opinions expressed above are strictly
those of the author(s).  The content of this message has
not been reviewed nor approved by any entity whatsoever.
--------------------------------------------------------
Paul FM         Info: http://paulfm.com/~paulfm/
--------------------------------------------------------

