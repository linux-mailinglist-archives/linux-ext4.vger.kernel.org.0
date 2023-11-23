Return-Path: <linux-ext4+bounces-128-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC4A7F6432
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Nov 2023 17:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A806A281B0E
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Nov 2023 16:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D913D963;
	Thu, 23 Nov 2023 16:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EfWDUK6w"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F237D7F
	for <linux-ext4@vger.kernel.org>; Thu, 23 Nov 2023 08:41:57 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-548f74348f7so1537405a12.2
        for <linux-ext4@vger.kernel.org>; Thu, 23 Nov 2023 08:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700757715; x=1701362515; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hrJOVqWZyXV3tJNMbwk0Hktw++SEqtTU6CT36WDZi5A=;
        b=EfWDUK6wEttvnkRF1yPhC2U0mY/VhEYFlqf/Gr29i7TYv+QH134Jm0NA1MclDZcGSw
         SxFQfpUOgfnONqhd7EoiVXkNr1ApW67paO0/oqNoaxcVwWfysnG7xqVJ+B9dA8XPm7Ab
         9tyWV3pARXbHmtxS/zQZYtroATPEH3XaDksdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700757715; x=1701362515;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrJOVqWZyXV3tJNMbwk0Hktw++SEqtTU6CT36WDZi5A=;
        b=AhYLCFN3a0k7tRv274Hqoydo8QfotfWY5vDyh1luWL78b6wNtuHnqlmJcIwC+3kJRl
         2EKG6xXYglZz8SENTuFN3GGPsrWa0qTHu0dhXTMwr72+uruuxEq6D9YBqju/3Kspndn7
         N//PyMr99chQ1v0XVq2aacalIJ0kWhJ3sIJXIymt+WmqzLY8HQPWhRlCV6ogOSvKQ9p8
         lbNACTNRAyPlutJSGAtnyu50m2bRm2o3WXsQ+WjWov7r6WhtkOoJEE65ySk6SdowxOD2
         zNKcghIDWY91XoQ35nvnzeF4LeeLsRszYIVADM5VGKAtLigT10JnYUWV9C71oj7uLvm/
         AaLA==
X-Gm-Message-State: AOJu0Yy+3rG5dOneIUvVV/K3DFqxV6rPLVOCursP34gYBVm6AwXfO94S
	Ax/RnO9vtJX39v9BOKospStOnxmY3enW9YUAfmh5k3ny
X-Google-Smtp-Source: AGHT+IGU4OT04frKhZOtVSrARipeOnCfPkhEH7GerIACslYrVhh2hlLi+zLqPv1/cCr4NOw34NoVoA==
X-Received: by 2002:a05:6402:35cc:b0:54a:92db:be47 with SMTP id z12-20020a05640235cc00b0054a92dbbe47mr2575158edc.42.1700757715630;
        Thu, 23 Nov 2023 08:41:55 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id l14-20020aa7d94e000000b0053e15aefb0fsm813876eds.85.2023.11.23.08.41.54
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 08:41:54 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-548f74348f7so1537376a12.2
        for <linux-ext4@vger.kernel.org>; Thu, 23 Nov 2023 08:41:54 -0800 (PST)
X-Received: by 2002:aa7:dcc4:0:b0:548:a0e8:4e51 with SMTP id
 w4-20020aa7dcc4000000b00548a0e84e51mr4040787edu.39.1700757714239; Thu, 23 Nov
 2023 08:41:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230816050803.15660-1-krisman@suse.de> <20231025-selektiert-leibarzt-5d0070d85d93@brauner>
 <655a9634.630a0220.d50d7.5063SMTPIN_ADDED_BROKEN@mx.google.com>
 <20231120-nihilismus-verehren-f2b932b799e0@brauner> <CAHk-=whTCWwfmSzv3uVLN286_WZ6coN-GNw=4DWja7NZzp5ytg@mail.gmail.com>
 <20231121022734.GC38156@ZenIV> <20231122211901.GJ38156@ZenIV>
 <CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com> <655f7665.df0a0220.58a21.e84fSMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <655f7665.df0a0220.58a21.e84fSMTPIN_ADDED_BROKEN@mx.google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 23 Nov 2023 08:41:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgADgC_+Nmamrzei7JpRDa7ugvP8P_8zS2VxB5ksF9Khg@mail.gmail.com>
Message-ID: <CAHk-=wgADgC_+Nmamrzei7JpRDa7ugvP8P_8zS2VxB5ksF9Khg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Support negative dentries on
 case-insensitive ext4 and f2fs
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, tytso@mit.edu, 
	linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org, 
	linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Nov 2023 at 07:57, Gabriel Krisman Bertazi
<gabriel@krisman.be> wrote:
>
> The problem I found with that approach, which I originally tried, was
> preventing concurrent lookups from racing with the invalidation and
> creating more 'case-sensitive' negative dentries.  Did I miss a way to
> synchronize with concurrent lookups of the children of the dentry?  We
> can trivially ensure the dentry doesn't have positive children by
> holding the parent lock, but that doesn't protect from concurrent
> lookups creating negative dentries, as far as I understand.

I'd just set the "casefolded" bit, then do a RCU grace period wait,
and then invalidate all old negative dentries.

Sure, there's technically a window there where somebody could hit an
existing negative dentry that matches a casefolded name after
casefolded has been set (but before the invalidation) and the lookup
would result in a "does not exist" lookup that way.

But that seems no different from the lookup having been done before
the casefolded bit got set, so I don't think that's an _actual_
difference. If you do a lookup concurrently with the directory being
set casefolded, you get one or the other.

And no, I haven't thought about this a ton, but it seems the obvious
thing to do. Temporary stale negative dentries while the casefolded
bit is in the process of being set seems a harmless thing, exactly
because they would seem to be the same thing as if the lookup was done
before...

And yes, that "wait for RCU grace period" is a somewhat slow
operation, but how often do the casefolded bits get changed?

This is not a huge deal. I don't hate your approach, I just found it surprising.

                 Linus

