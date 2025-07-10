Return-Path: <linux-ext4+bounces-8912-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D823DAFFC13
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Jul 2025 10:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAF7E7AB42E
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Jul 2025 08:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1BA28C5B0;
	Thu, 10 Jul 2025 08:23:05 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7F428BAA4
	for <linux-ext4@vger.kernel.org>; Thu, 10 Jul 2025 08:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752135785; cv=none; b=okZjplS1himcQPOfSj70JhJExXxndeMirJdNQgAImJU8wlLJw3S7yap4biK42DzhemjKMqOpZYpXQQ8L2qD0560G9S/Bo5aXxyJI6NLd7xnI4CaP1mXQJ6FVI+ahMH10xd22u1nRJr0uWBJ+G7yGyuNYweD/7iuPdMLRsnyNXOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752135785; c=relaxed/simple;
	bh=HTRdX9JXkzjdE4/G8zQBCJH3UljSDAiFGMNt1gA7MUM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PXISi0qd9o+Bn2NZPYT2Sn6i2hheswzaNftJyKQv28aETb8o3VY0JAOE5YUq+PWC5bd29apBe5/IZ1MSvnYxK0h8j7+h/2SZhXJMI8JhOQX9BFgnLVA44/hxoDIv09JDDznOh97GDoK19f0oWWBISVzBhaZjeLjl6CjkmUG40b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8730ca8143eso186033239f.0
        for <linux-ext4@vger.kernel.org>; Thu, 10 Jul 2025 01:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752135783; x=1752740583;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JDTcowXLJsolFMOqnIwMSKD2MghWzo41D8JtLx5ckjo=;
        b=mnGcfmRBoqGjp+nAvmH1DWU7nXiRAvAt7QQxfZcZ1ba6t2wwzGH0cz4dUiG0lzJ3bY
         fjkRCTzcywj1k4Y+lbU8sqhrNN3Na1u9wjf3utv2ObBQ9MR8jmuV98bvWMypCeUi/2RW
         nObdtAP3DbQo0UKmqAIkEKopypcOGxQVt0dkzyn63wHkjd60S/PlNKrbzExUe7dTFThb
         f/oes0I89CeS0dzCuCuSy5AfBriVUVe4G+PR0c3/XO/jcJhcCaZWeAfkEzZLf3oWN0av
         G00gLMbYngqjSKmuJQZ2uVocGg+IL9M2VkaCpsnhz+6yqs7ReTq7B2BLsWgNPB0L4K0u
         XcQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQDoM5fNpI4ij7329Ne7iZCYjpozvSx0AufG2nqrTroqq6piilIMq7+VZKlAYENWWrMEGpGVQvKwPj@vger.kernel.org
X-Gm-Message-State: AOJu0YwTBOe3/eZlKH9+LqxZ0lyxwQt8ygVr1i43EL71EtEYgMVTxR0v
	MWnlIJTdYnn+6CUK21/t4dx0teGLzPTqy/HuRDwWl2Q8FhjggkV0kXaZzcQJsYUK61KCuGRe3QB
	RUsOVo3RCkNqrQk7F9imd8T/o9yT7fUh+qdh2afNi4k73Rm5typsT7mKmjfo=
X-Google-Smtp-Source: AGHT+IHFpX6xqreYhQBwMbJ3rw/SSk38OjUtZ3pEQfn02T8buMjygtC9DyD7TCWS0HzF/ACkDIqMn1VFAG6ZxKaWs0PzIc/j7JF8
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2cc2:b0:867:973:f2cb with SMTP id
 ca18e2360f4ac-87966fa2ad6mr294615039f.7.1752135783281; Thu, 10 Jul 2025
 01:23:03 -0700 (PDT)
Date: Thu, 10 Jul 2025 01:23:03 -0700
In-Reply-To: <CAF3JpA7a0ExYEJ8_c7v7evKsV83s+_p7qUoH9uiYZLPxT_Md6g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686f7867.050a0220.385921.002f.GAE@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_update_inline_data
From: syzbot <syzbot+544248a761451c0df72f@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, moonhee.lee.ca@gmail.com, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+544248a761451c0df72f@syzkaller.appspotmail.com
Tested-by: syzbot+544248a761451c0df72f@syzkaller.appspotmail.com

Tested on:

commit:         8c2e52eb eventpoll: don't decrement ep refcount while ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14ff7582580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b309c907eaab29da
dashboard link: https://syzkaller.appspot.com/bug?extid=544248a761451c0df72f
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15ef7582580000

Note: testing is done by a robot and is best-effort only.

