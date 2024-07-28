Return-Path: <linux-ext4+bounces-3501-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF0C93E9C0
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jul 2024 23:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AD8B1F21503
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jul 2024 21:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBEE78C70;
	Sun, 28 Jul 2024 21:43:04 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21477470
	for <linux-ext4@vger.kernel.org>; Sun, 28 Jul 2024 21:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722202984; cv=none; b=usR6coKqXbYWeKwOCW3xYU8+6vLWHPe2TA7wiIy3Fw7hw2W1xSbwU5kqeg7XLZimYzK04SGh0nEQQaG/elPIp1JeuppDHCv98UQ91k81GOM9kFyla6gPn2dAeGHwDXXVHiE19T3xWsGUkqm4s7q421AbDR+41I/4ArdU+hXZBWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722202984; c=relaxed/simple;
	bh=MYduZ0IdORuSmWQu5YXNctyDIni5ClmQH5IEUUo18/8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HRy/9JL+gdSPst8nngZ1JfP7K5HMXbrHKnpZZc7/PoF9wJNKs7MC8l3Qj/3JFKHGRKQ9bMu405+MEhWUqMCEI/cp5Nqz8Weikf8Sl57ON3yoJCrbKEt8OOzJeV61QE4hTyCBEFryoRBDLPbJQpXtYS7Oy9g3VBynrwpME5bqq0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f869f653fso447268839f.1
        for <linux-ext4@vger.kernel.org>; Sun, 28 Jul 2024 14:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722202982; x=1722807782;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QgeFmqomSS4eKslD4QaSEsWobihSIfo0Ye5W+dY4btg=;
        b=V3KP0Yj/hpxd4ztEyUdFwxCDShPXco+GV5srFQHMr0+2mvLfn/eSqoS+YEf7vYjYtd
         vfkBkJ6qCIwL0u7uxsob3jeE/jkcZOYKOVXJd4mehx4AyRHreAh791zRKbLIyjSX9V7H
         qCUlwINO1D8q969Fw0EAw+hGwfSuMhfk5B07lx4IvNjo4+geOrBgjOlYQbINLKVbHTkh
         hlSd/DgfL+1UVTxO1fTJJoA2RtnSmuJlYBqBYg4Uen/CZgNcWLLmG40HVxEUeE/2iJ/K
         Z3aB6OJYHofK882gUUHXDDeFUbbtF7REn9TuLtZUr1hSf1DdluY2EwB7iGi+7Y0YW8Tq
         +jWA==
X-Forwarded-Encrypted: i=1; AJvYcCVa9da63tJT4+oFr5/GKhBSP7M1yLBiwXmXv5tuHIXq3HqdRDDT6eb9QqokKC7H8Gego77S4q5YZV0C7An70JvRjDY3gLXHhEQFaQ==
X-Gm-Message-State: AOJu0Ywlwi+qX7dlPUATU2si8uSiRp5WcijrMtr1RISmfhqxxnpcaU87
	J8lhUVg4plDY91+CByd8awk2DZu1bErYMJFaN/J3z1cGZtSS9SN7Jcj9ltAQA712+A/KWVVCxuK
	4RwtTy6GvRdPdrcu2YPmfK22N9nu8ZzbW4w9z5OB0IZF2vn0ZXk13ct4=
X-Google-Smtp-Source: AGHT+IHYOQdWon2gqthL7m7IB3zOfELdp40XTGsJ7KaDanvxoPsy9ppv0v6sUc3XWLnVY4wPky7BNhk6t2qKnjUfIwWajDoVCUO+
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d05:b0:80c:826f:ae77 with SMTP id
 ca18e2360f4ac-81f960b9a57mr15715039f.2.1722202981854; Sun, 28 Jul 2024
 14:43:01 -0700 (PDT)
Date: Sun, 28 Jul 2024 14:43:01 -0700
In-Reply-To: <00000000000099a654061e4a0d97@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f70500061e55a074@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-out-of-bounds Read in ext4_read_inline_dir
From: syzbot <syzbot+ee5f6a9c86b42ed64fec@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, asml.silence@gmail.com, axboe@kernel.dk, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit e5598d6ae62626d261b046a2f19347c38681ff51
Author: Pavel Begunkov <asml.silence@gmail.com>
Date:   Thu Aug 24 22:53:31 2023 +0000

    io_uring: compact SQ/CQ heads/tails

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=179f26bd980000
start commit:   910bfc26d16d Merge tag 'rust-6.11' of https://github.com/R..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=145f26bd980000
console output: https://syzkaller.appspot.com/x/log.txt?x=105f26bd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b698a1b2fcd7ef5f
dashboard link: https://syzkaller.appspot.com/bug?extid=ee5f6a9c86b42ed64fec
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ddcb03980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11cb739d980000

Reported-by: syzbot+ee5f6a9c86b42ed64fec@syzkaller.appspotmail.com
Fixes: e5598d6ae626 ("io_uring: compact SQ/CQ heads/tails")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

