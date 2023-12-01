Return-Path: <linux-ext4+bounces-264-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F428011BC
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Dec 2023 18:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C82A280C5C
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Dec 2023 17:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548744E1C7;
	Fri,  1 Dec 2023 17:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZIu5K5WI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F07D50
	for <linux-ext4@vger.kernel.org>; Fri,  1 Dec 2023 09:30:59 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c9b5e50c1fso33155011fa.0
        for <linux-ext4@vger.kernel.org>; Fri, 01 Dec 2023 09:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701451857; x=1702056657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1am1ieNRlB1Htjz37b+iyeXn+rb4Ke6OiBhb7slVJQ=;
        b=ZIu5K5WImkFF0rNpOYVijhWI7WyJF8GMD/a1EB4wd8Ra7nf4hHUj6Nr6veWWYBmM3G
         Hzf2MBAz0t2YL+lC5b5KuaTRfOvyDfstnKYQi5eN9KWbxctRI5O7GqfRxDDIRqrzc8uB
         kTVbb1lSjfiwGVg3KtNH68rMDrcpa9k8kxi08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701451857; x=1702056657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1am1ieNRlB1Htjz37b+iyeXn+rb4Ke6OiBhb7slVJQ=;
        b=TEsue/9auwbQLosPM4ufdO5lQto9+1K8ZwkWO1jpd5g4fAJiuD34COZVGCaM0IXzxP
         o0mdU5yyqsv4zQY0PnQ+Z2h+2G6ZTl9k8/nm6gUYyziiPDcMKpBjZDH+40IxcU/TVPYK
         4h+BfdXwpO8M3PDzFW8GxjyixLMkPMiNBxZdrXS1XZtT4I4u2R9VhPi7u/3szfGYHEG6
         2de/HEK1ismIo1gLoqaJpRRjNBquimo845zXcd3zJV8qsneTPP7PVz22F9zjfmTollBN
         SUD7XzKk3NkZEPO/FkcHVPGV/NhjBzw2WIujHXcah3gTo9FiGO3LxOfkzxPBCoH705fP
         ZScA==
X-Gm-Message-State: AOJu0YxBM3tuwN9U3do9M+qt1+q166BQn4ljTMZK0GRwVNG/Fu6k9ouC
	jSHAR+YGJzzkCsNt3gPYWxXApT/F/pHE9HJcD+E=
X-Google-Smtp-Source: AGHT+IEdiMMovu7RA1yAh6nOQa0N8lwgWu3w4kEChK6W+0XPeYJ6CgCj1OpJaeTFRRwKx6tNUlJAiA==
X-Received: by 2002:a2e:7303:0:b0:2c9:d862:ff33 with SMTP id o3-20020a2e7303000000b002c9d862ff33mr519369ljc.84.1701451857362;
        Fri, 01 Dec 2023 09:30:57 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id oy13-20020a170907104d00b00a0b66ef92dfsm2108200ejb.218.2023.12.01.09.30.56
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 09:30:56 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40b4f60064eso23694525e9.1
        for <linux-ext4@vger.kernel.org>; Fri, 01 Dec 2023 09:30:56 -0800 (PST)
X-Received: by 2002:a1c:7705:0:b0:40b:5e59:f723 with SMTP id
 t5-20020a1c7705000000b0040b5e59f723mr324085wmi.149.1701451855947; Fri, 01 Dec
 2023 09:30:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201000126.335263-1-briannorris@chromium.org> <20231201162410.GA36164@frogsfrogsfrogs>
In-Reply-To: <20231201162410.GA36164@frogsfrogsfrogs>
From: Brian Norris <briannorris@chromium.org>
Date: Fri, 1 Dec 2023 09:30:38 -0800
X-Gmail-Original-Message-ID: <CA+ASDXPYufpx0uaC7iyo_cgaa_2XdR+OLBvMDKk=rpwJe1hWXQ@mail.gmail.com>
Message-ID: <CA+ASDXPYufpx0uaC7iyo_cgaa_2XdR+OLBvMDKk=rpwJe1hWXQ@mail.gmail.com>
Subject: Re: [PATCH] lib/ext2fs: Validity checks for ext2fs_inode_scan_goto_blockgroup()
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 8:24=E2=80=AFAM Darrick J. Wong <djwong@kernel.org> =
wrote:
> On Thu, Nov 30, 2023 at 04:01:18PM -0800, Brian Norris wrote:
> > This resolves issues seen in ureadahead, when it uses an old packfile
> > (with mismatching group indices) with a new filesystem.
>
> Say what now?  The boot time pre-caching thing Ubuntu used to have?
> https://manpages.ubuntu.com/manpages/trusty/man8/ureadahead.8.html

Sure. ChromeOS still uses it. Steven Rostedt even bothered to do a
talk about it recently:
https://eoss2023.sched.com/event/1LcMw/the-resurrection-of-ureadahead-and-s=
peeding-up-the-boot-process-and-preloading-applications-steven-rostedt-goog=
le

Brian

