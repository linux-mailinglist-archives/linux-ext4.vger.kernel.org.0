Return-Path: <linux-ext4+bounces-42-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CE67F1BF7
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Nov 2023 19:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 913E9281901
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Nov 2023 18:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B7030324;
	Mon, 20 Nov 2023 18:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QZlWxbXP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E930A4
	for <linux-ext4@vger.kernel.org>; Mon, 20 Nov 2023 10:08:12 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507a0907896so6608296e87.2
        for <linux-ext4@vger.kernel.org>; Mon, 20 Nov 2023 10:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700503690; x=1701108490; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bt4pvFuDO1h6defOBt353/3Gu2TKhLOMI2PK2iWD2i4=;
        b=QZlWxbXPqBz7Ho7KOLdqJDUz/pE3QnuydllAtMH8cviNqaHiNkURQQHz8+9ZeWC6Dd
         IRIOSXk8x9KDLPjwI6/xmFBe07/YPpZC59fFgd27ravVT/H/Q2Wc8FH2KR9SCtuWfE/Z
         gOOZ9QgQzgpblakMPmQeKORt02eB/lR9iWDCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700503690; x=1701108490;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bt4pvFuDO1h6defOBt353/3Gu2TKhLOMI2PK2iWD2i4=;
        b=P9VDvMvqwNPxNwgT0kNHYFu644aCvmwDYqiwKHdiOcNaPGwCHXhlq1S69KQ4PjFGub
         DbDV505GycOfQRTrZuGz604JbFUiMf0P8sOYYrK7nn34hbzc64DywpQTCNbMiv4HxtcF
         +jZZ/JMg8kNsNGgroMvPxvoP4gaXwcRJ89YKj5FgRnsw7+WiadJQptp2GCPtxipXQa+4
         rDlzi2iYowOdxldT+M7owxtu836T6h7CJHC/g00Z2lkdZKCTyM60o7/rqDDORuofOdyB
         4pUhLwlPvETfldmn3xLohT4I8sxlDREVbmSzq9gXWbXaTclrldQYoDsQEM6i4YbbcMd9
         hvfg==
X-Gm-Message-State: AOJu0YygwBMIXLjQiFYGLNUFSudYt1qwLgK7R1GlI53M837/hQbEVQFu
	uE4eJS89vAiy+4KV7j04bz/6OkIGIOc0DvCPezOajg==
X-Google-Smtp-Source: AGHT+IGRqKk1pdh6f5Hi3bSV/uz/3b4254vAq1FdsM3RQTuiZya9/Jl/d3Z/CyhXy3+g3/uHqMVxxg==
X-Received: by 2002:ac2:43a5:0:b0:501:c406:c296 with SMTP id t5-20020ac243a5000000b00501c406c296mr5832784lfl.31.1700503689744;
        Mon, 20 Nov 2023 10:08:09 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id c22-20020a056402121600b00548c18fad8esm1248015edw.39.2023.11.20.10.08.08
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 10:08:08 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-548d1f8b388so1448689a12.0
        for <linux-ext4@vger.kernel.org>; Mon, 20 Nov 2023 10:08:08 -0800 (PST)
X-Received: by 2002:a05:6402:150f:b0:548:7900:2d0c with SMTP id
 f15-20020a056402150f00b0054879002d0cmr100825edw.40.1700503687823; Mon, 20 Nov
 2023 10:08:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230816050803.15660-1-krisman@suse.de> <20231025-selektiert-leibarzt-5d0070d85d93@brauner>
 <655a9634.630a0220.d50d7.5063SMTPIN_ADDED_BROKEN@mx.google.com> <20231120-nihilismus-verehren-f2b932b799e0@brauner>
In-Reply-To: <20231120-nihilismus-verehren-f2b932b799e0@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 20 Nov 2023 10:07:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=whTCWwfmSzv3uVLN286_WZ6coN-GNw=4DWja7NZzp5ytg@mail.gmail.com>
Message-ID: <CAHk-=whTCWwfmSzv3uVLN286_WZ6coN-GNw=4DWja7NZzp5ytg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Support negative dentries on
 case-insensitive ext4 and f2fs
To: Christian Brauner <brauner@kernel.org>
Cc: Gabriel Krisman Bertazi <krisman@suse.de>, viro@zeniv.linux.org.uk, tytso@mit.edu, 
	linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org, 
	linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Nov 2023 at 07:06, Christian Brauner <brauner@kernel.org> wrote:
>
> My current understanding is that core dcache stuff is usually handled by
> Al. And he's got a dcache branches sitting in his tree.
>
> So this isn't me ignoring you in any way. My hands are tied and so I
> can't sort this out for you easily.

Well, we all know - very much including Al - that Al isn't always the
most responsive person, and tends to have his own ratholes that he
dives deep into.

The good news is that I do know the dcache code pretty well, and while
I really would like Al to deal with any locking issues (because
"pretty well" is not "as well as Al Viro"), for just about any other
issue I'll happily take pulls from you.

I dislike case folding with a passion - it's about the worst design
decision a filesystem can ever do - but the other side of that is that
if you have to have case folding, the last thing you want to do is to
have each filesystem deal with that sh*t-for-brains decision itself.

So moving more support for case folding into the VFS so that the
horrid thing at least gets better support is something I'm perfectly
fine with despite my dislike of it.

Of course, "do it in shared generic code" doesn't tend to really fix
the braindamage, but at least it's now shared braindamage and not
spread out all over. I'm looking at things like
generic_ci_d_compare(), and it hurts to see the mindless "let's do
lookups and compares one utf8 character at a time". What a disgrace.
Somebody either *really* didn't care, or was a Unicode person who
didn't understand the point of UTF-8.

Oh well. I guess people went "this is going to suck anyway, so let's
make sure it *really* sucks".

The patches look fine to me. Al - do you even care about them?

                   Linus

