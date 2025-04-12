Return-Path: <linux-ext4+bounces-7215-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA8AA86F55
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Apr 2025 22:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5897319E176F
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Apr 2025 20:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75D91FF1D9;
	Sat, 12 Apr 2025 20:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NfDPamOs"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEBC19E965
	for <linux-ext4@vger.kernel.org>; Sat, 12 Apr 2025 20:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744489381; cv=none; b=KvLkK2HpJl03zzF+qBufDvcZGgLP0PGjcq7G/lBcCCAF9oubbD7WYriejwO+OOgNqENFBLTmqHE9nGsY8sYIr0iJ/qTNuVnUXF7ZlZQVQWEQhgRRiXxo877gRrV884hDqudR7asxOHUMoX1mwe8NTg9slhxl0lIQ/oz7D9rj/6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744489381; c=relaxed/simple;
	bh=6Y5KdDVzjvazrOIApCipo1B6aUyEJJR4k42kybjK5BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DcHz5YzWgXQ3ODIhGwU0QebfdS0Mk2XI7Pmt1qI9esMCBvoeeO/yXyx3cxlcTEG35xQ4ZJoj0tCV5mtBIOVb7UaAl+XD091emQfDtk001q3WMPJ5NaocBSuhv5sbwKgF7nVY9LiqLG919Yf63FtOU+mT+SlqL5WSbhhuytKBQNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NfDPamOs; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e66407963fso5630735a12.2
        for <linux-ext4@vger.kernel.org>; Sat, 12 Apr 2025 13:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1744489377; x=1745094177; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d/539aLu+mB+lczaep/CgFHmero7rpBQwrzIrFuK2HQ=;
        b=NfDPamOsUabEm9iE9b6aLdHvLQC2tvdugdDwmWxgWqyPa4pIBU1OG/PB4g4c/P6i+O
         0ahazAIpiNddUbYStSOO2Fte9G2Qu0FwgT9geheyJXvwLlSApBXLP9dCoSlsc2p2DAUI
         3oj9C5sF1NmeI/cI4rqxttWfxelW1l3UK9ZXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744489377; x=1745094177;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/539aLu+mB+lczaep/CgFHmero7rpBQwrzIrFuK2HQ=;
        b=dBxTtV4MfV7Hg0mqBSg1gP+pLq5czmPLJBpR431GlZ6d/oNTOukKq69Kh06QRxKara
         GkLkHUJ1X1lbxkL7J/mVsvduBYWl8zn/kmx5EA15+RCTWV/tXymqwx7kcwxLun4QiGKB
         YdlTRwCgbSF830l212LjD6oMNQbVV122NRJs87ZDd2XNj7lG0++9VKTvwfcKn3ZGDol9
         WE+j00PKDOLQc8gRG+Oht+HnZrTay6IbCs9AYDrSYvC320NXyFwvPcIsAz9cK5CKsk+V
         P0ZSnm0b+mB9f1dPlVc6iP58IIHcVJAZQNxO+ytnpjxZ3Lj9tLos6mw9jeV/zjkfXZVq
         ecvA==
X-Forwarded-Encrypted: i=1; AJvYcCWv23tBRNQJ+tlRdFt6fi5tsQtZlT3ai0Uv52Xex9seuVC6695D8aOVGd2dBh186dCOPAdzCeNUoYn7@vger.kernel.org
X-Gm-Message-State: AOJu0Yyum7QNjfipbHtVM0pCRVJhIdWyI0K3p2C7/icdhx+c5fvoPc4O
	asMZZpPCAABDiMzGzwA27IMQXuGI/dmNSp2YwzCapbj2DnTPMX/I2psSDRM2c9tHKpOBRja0fn6
	9suo=
X-Gm-Gg: ASbGncurgN41T35tscOEfGvjAf13DGp68gPAGKBBG04iwzGunNhEOC6hIuBJDj1vJXp
	UY1JfZ9U29fOP6woFddzl2pmDbPpnGZsw//JuLCfgvuov98YhqUSEQcv/DmpnEoyJPa9vtgQnfF
	q2UbolDkMAdSDK+QHY3Vv5K6jfsowGIHPw+XL+RFkkyYLFvGStqFxM6YJDDrR440n9qHIbARct3
	zDKvmQ9XSioX/tEdNFybut16MtIjrc/VlEnF+rgpBLPPZQ9tXrxkvh6MGEm8/eVnEcjn3Ata4Pk
	0D7Mp8hA7ZH2ypFq5blwa0EY3EkNfYoP3Izefzw11nv4/7jb2Q3ojmWinTbu11mbcqnd9kYdNVK
	PYbXof7pief/2dQONnpP55QeBMA==
X-Google-Smtp-Source: AGHT+IEvgz1cEZ0VvMTL+VMA7UwlRg+Q+mqEfC/1nc5mGlgKUS1U94E6+1hpwJjUIbkPK7IwIx/r0w==
X-Received: by 2002:a05:6402:448e:b0:5f3:7f32:3b04 with SMTP id 4fb4d7f45d1cf-5f37f32430fmr4961443a12.29.1744489376683;
        Sat, 12 Apr 2025 13:22:56 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36f5056b9sm2545833a12.51.2025.04.12.13.22.55
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Apr 2025 13:22:55 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e66407963fso5630713a12.2
        for <linux-ext4@vger.kernel.org>; Sat, 12 Apr 2025 13:22:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHe7xw7n2KmgftW88259fRX+pQb8IRP4EZbZoA+XoPJytwy8oaYDrcquSHHaS1rh5x7ZzpxnKfKt/t@vger.kernel.org
X-Received: by 2002:a17:907:f1e0:b0:aca:e220:8ebc with SMTP id
 a640c23a62f3a-acae22090efmr370708266b.25.1744489375035; Sat, 12 Apr 2025
 13:22:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whJgRDtxTudTQ9HV8BFw5-bBsu+c8Ouwd_PrPqPB6_KEQ@mail.gmail.com>
 <20241031-klaglos-geldmangel-c0e7775d42a7@brauner> <CAHk-=wjwNkQXLvAM_CKn2YwrCk8m4ScuuhDv2Jzr7YPmB8BOEA@mail.gmail.com>
 <CAHk-=wiKyMzE26G7KMa_D1KXa6hCPu5+3ZEPUN0zB613kc5g4Q@mail.gmail.com>
 <CAHk-=wiB6vJNexDzBhc3xEwPTJ8oYURvcRLsRKDNNDeFTSTORg@mail.gmail.com>
 <CAHk-=whSzc75TLLPWskV0xuaHR4tpWBr=LduqhcCFr4kCmme_w@mail.gmail.com>
 <a7gys7zvegqwj2box4cs56bvvgb5ft3o3kn4e7iz43hojd4c6g@d3hihtreqdoy>
 <CAHk-=wgEvF3_+sa5BOuYG2J_hXv72iOiQ8kpmSzCpegUhqg4Zg@mail.gmail.com> <CAGudoHGxr5gYb0JqPqF_J0MoSAb_qqoF4gaJMEdOhp51yobbLw@mail.gmail.com>
In-Reply-To: <CAGudoHGxr5gYb0JqPqF_J0MoSAb_qqoF4gaJMEdOhp51yobbLw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 12 Apr 2025 13:22:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+pk72FM+a7PoW2s46aU9OQZrY-oApMZSUH0Urg9bsMA@mail.gmail.com>
X-Gm-Features: ATxdqUFGJ-r2ok5MOh_Re055tlx2zhUC_4ZHvO5jGJV_FifGa7Yruu_r-HNtF4w
Message-ID: <CAHk-=wh+pk72FM+a7PoW2s46aU9OQZrY-oApMZSUH0Urg9bsMA@mail.gmail.com>
Subject: Re: generic_permission() optimization
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>, 
	Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 12 Apr 2025 at 09:26, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> I plopped your snippet towards the end of __ext4_iget:

That's literally where I did the same thing, except I put it right after the

          brelse(iloc.bh);

line, rather than before as you did.

And it made no difference for me, but I didn't try to figure out why.
Maybe some environment differences? Or maybe I just screwed up my
testing...

As mentioned earlier in the thread, I had this bi-modal distribution
of results, because if I had a load where the *non*-owner of the inode
looked up the pathnames, then the ACL information would get filled in
when the VFS layer would do the lookup, and then once the ACLs were
cached, everything worked beautifully.

But if the only lookups of a path were done by the owner of the inodes
(which is typical for at least my normal kernel build tree - nothing
but my build will look at the files, and they are obviously always
owned by me) then the ACL caches will never be filled because there
will never be any real ACL lookups.

And then rather than doing the nice efficient "no ACLs anywhere, no
need to even look", it ends up having to actually do the vfsuid
comparison for the UID equality check.

Which then does the extra accesses to look up the idmap etc, and is
visible in the profiles due to that whole dance:

        /* Are we the owner? If so, ACL's don't matter */
        vfsuid = i_uid_into_vfsuid(idmap, inode);
        if (likely(vfsuid_eq_kuid(vfsuid, current_fsuid()))) {

even when idmap is 'nop_mnt_idmap' and it is reasonably cheap. Just
because it ends up calling out to different functions and does extra
D$ accesses to the inode and the suberblock (ie i_user_ns() is this

        return inode->i_sb->s_user_ns;

so just to *see* that it's nop_mnt_idmap takes effort.

One improvement might be to cache that 'nop_mnt_idmap' thing in the
inode as a flag.

But it would be even better if the filesystem just initializes the
inode at inode read time to say "I have no ACL's for this inode" and
none of this code will even trigger.

                  Linus

