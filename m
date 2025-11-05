Return-Path: <linux-ext4+bounces-11488-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0557C3581A
	for <lists+linux-ext4@lfdr.de>; Wed, 05 Nov 2025 12:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BB794FB248
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Nov 2025 11:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62224311966;
	Wed,  5 Nov 2025 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVQJJ/r+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5794130F957
	for <linux-ext4@vger.kernel.org>; Wed,  5 Nov 2025 11:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762343426; cv=none; b=WbmG7QrA1G5g9kUFDs8o3qokaSBwvwfLVJsQrOhn6oSDrbVpmEM0rW31LblObw+X7dxtithVGdZPYeFHSWodL/witHpywLuCTPUE6JG3LZWK4vbxe5EmJ5TmSunrkFDTzMYg2n1NirVFyR/hGy/yXas10XQyInytc+DaLnizV9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762343426; c=relaxed/simple;
	bh=CN1LseI8wwaJJz+Yhu+BcRAFCY+7Ou3dAsGH6hbaFl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c4+TKCvoMnwgtJw2jrirWZn831MJoEbM11SIYXadijUD4I3nxvOx7gFmkOwrZaXpf7YdQXJVO4TsuugKlNXLCiUhfTW+SIJxPyQQqOP5dfhQUL4W6VkzJZw4YrMrM1KNfQrzE9o6/RgyHkFywZrjLK0z33noQivaihieI6zpQK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVQJJ/r+; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b727f330dd2so27310366b.2
        for <linux-ext4@vger.kernel.org>; Wed, 05 Nov 2025 03:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762343423; x=1762948223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/psyIBp1deb+sQYGw/uMYU7k4vt3eFFEkdfa8ASj+ds=;
        b=fVQJJ/r+ZjX44d8LXn4NgHlpp/d/oo/58YT8GjIgIa2097w+VrCmukq0yfHcI5gypG
         c5W/QkZa/Bq51pIMPuDzc7XxvfdlYxmWNMZBrwKjuFTx3W0yKD4S5+1MpWP08uPhr37H
         sr/HqWbeh2aSFkypaYgwu34CNW8aOLJwOA3X7z7ag3cQQuvxXt3efoMcPbGk1mP8v4fO
         f1ySJLAYrFvVCsrQEpOAzbKrx0sXom+vafK46pBAHPvsI5MZpYbPNwUHq5l/Tu3j3rys
         tUmcx5eXlBT3bVjgdATdEkw+2ugG7xJUd0Mz/EYrPrPhBwoJ5iJfPeLTMXEyW4ozP7YY
         cyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762343423; x=1762948223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/psyIBp1deb+sQYGw/uMYU7k4vt3eFFEkdfa8ASj+ds=;
        b=BgeoFfJcmeXwI/SbmxsnR/jFw4vnsC99jeEay971GEPDiaXw+RImGhlNt3rhUKoR+T
         sTmSyKMtskJlEsntsSE8sDF4Y7YrrXzNbmOUs/EtN/4oTcl0/qy4+qKXAZx1Sq/4w6KC
         zNkyf4pMhVfMkUM+lPnUTu1h7fiqiXVYi61cNWUCU/YWU0GOMV5TnD9wpnGUyVweE4+G
         5MAurgrz5mV/DdZ1AXvL1Czidp/iQ0C3peHye7uejuJQB8QGOHFAMo1aSzvID6Pn3l3l
         Yz8nlH2CJLGu09kKsn6GIG1baYFUKZdUNoO42NI20mklLSHE985MbFleAlo0aA0qvC0D
         tE6A==
X-Forwarded-Encrypted: i=1; AJvYcCUG5EY6V8uk5pAoqSi7QlqRn6LsrlhpX17Mb1TAjr92KOkgA7/8cJMnYUwvaWiHKYGCTMFTxuTYzf9r@vger.kernel.org
X-Gm-Message-State: AOJu0YydlPCjA/YcgT/93KAfYyq6kZFQhsc3CbBx/UX+IBc1XaNuJOfv
	XRRRJGhvRNJEeh3s/keLNTq7x2x2xBlrIl2zWSuRqgjsK/KKdUp3j+P23OmEfy3qd87IaYjqqvq
	bpi2mSUC/dOjWL97z0WuXPUPF17Cijkk=
X-Gm-Gg: ASbGncvb8ojszmtvPKan8rIpBfv0zH7HC7O9PVS/kvNqdxcvnDb/wsGV2LLmDSUng3R
	R7Q7eXWJm8V6LTp/0/Pw6N792sxaSOIEszGtwC/1B3vjMQgoFkuvrvqhszfwbots0XiZXAfufp/
	/4S+DrLqbgX31JUk+8pVdlaz1OgudGKj++pDDoxEMXzK5bDBE4L7E5/IWo1JHFDNPQrXUrJlZZ9
	IiNy2EsM0hU83pbLky7Fdl/dvcTNzMTqybJZT3/pYXk0L6Y2gnfOzqN5h8yZTO5yVkwN8JWBCKM
	cma0qYatnWUXJ0k=
X-Google-Smtp-Source: AGHT+IEtU3lRWf5x1hxqjxtGZrq7F9QSfqDpcgBQPa1KDHc8/XkN76onavaj3uG4WD1930D5cSNesEukx/CuB7ZtOTA=
X-Received: by 2002:a17:906:730b:b0:b6d:6c1a:31ae with SMTP id
 a640c23a62f3a-b7265559368mr280494466b.49.1762343422441; Wed, 05 Nov 2025
 03:50:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiKyMzE26G7KMa_D1KXa6hCPu5+3ZEPUN0zB613kc5g4Q@mail.gmail.com>
 <CAHk-=wiB6vJNexDzBhc3xEwPTJ8oYURvcRLsRKDNNDeFTSTORg@mail.gmail.com>
 <CAHk-=whSzc75TLLPWskV0xuaHR4tpWBr=LduqhcCFr4kCmme_w@mail.gmail.com>
 <a7gys7zvegqwj2box4cs56bvvgb5ft3o3kn4e7iz43hojd4c6g@d3hihtreqdoy>
 <CAHk-=wgEvF3_+sa5BOuYG2J_hXv72iOiQ8kpmSzCpegUhqg4Zg@mail.gmail.com>
 <CAGudoHGxr5gYb0JqPqF_J0MoSAb_qqoF4gaJMEdOhp51yobbLw@mail.gmail.com>
 <20250412215257.GF13132@mit.edu> <CAHk-=wifig365Ej8JQrXBzK1_BzU9H9kqvvbBGuboF7CzR28VQ@mail.gmail.com>
 <20250412235535.GH13132@mit.edu> <CAGudoHEJZ32rDUt4+n2-L-RU=bpGgkYMroxtdMF6MQjKRsW24w@mail.gmail.com>
 <20250413124054.GA1116327@mit.edu>
In-Reply-To: <20250413124054.GA1116327@mit.edu>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 5 Nov 2025 12:50:10 +0100
X-Gm-Features: AWmQ_bnS1G1Gd1LQ2Jc6nGUipYMZeP5XUsL5HdztHQzw4JohAps7_MLiyL5Bq8Q
Message-ID: <CAGudoHFciRp7qJtaHSOhLAxpCfT1NEf0+MN0iprnOYORYgXKbw@mail.gmail.com>
Subject: Re: generic_permission() optimization
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Jan Kara <jack@suse.cz>, Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 13, 2025 at 2:40=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wrote=
:
>
> On Sun, Apr 13, 2025 at 11:41:47AM +0200, Mateusz Guzik wrote:
> > This is the rootfs of the thing, so I tried it out with merely
> > printing it. I got 70 entries at boot time. I don't think figuring out
> > what this is specifically is warranted (it is on debian though).
>
> Well, can you run:
>
> debugfs -R "stat <INO>" /dev/ROOT_DEV
>
> on say, two or three of the inodes (replace INO with a number, and
> ROOT_DEV with the root file system device) and send me the result?
> That would be really helpful in understanding what might be going on.
>
> > So... I think this is good enough to commit? I had no part in writing
> > the patch and I'm not an ext4 person, so I'm not submitting it myself.
> >
> > Ted, you seem fine with the patch, so perhaps you could do the needful(=
tm)?
>
> Sure, I'll put together a more formal patch and do full QA run and
> checking of the code paths, as a supposed a fairly superficial review
> and hack.
>

It looks like this well through the cracks.

To recount, here is the patch (by Linus, not me):
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index f386de8c12f6..3e0ba7c4723a 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5109,6 +5109,11 @@ struct inode *__ext4_iget(struct super_block *sb, =
unsigned long ino,
>                 goto bad_inode;
>         brelse(iloc.bh);
>
> +       if (test_opt(sb, DEBUG) &&
> +           (ext4_test_inode_state(inode, EXT4_STATE_XATTR) ||
> +            ei->i_file_acl))
> +               ext4_msg(sb, KERN_DEBUG, "has xattr ino %lu", inode->i_in=
o);
> +
>         unlock_new_inode(inode);
>         return inode;

In my tests it covered most real-world lookups on my debian box.

Sorting this out acts as blocker for a lookup optimization I'm working
on which bypasses all perm checking if an inode has a flag indicating
everyone can traverse through it.

