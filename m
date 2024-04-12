Return-Path: <linux-ext4+bounces-2045-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4367D8A22CD
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Apr 2024 02:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C557FB222D8
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Apr 2024 00:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B6CA31;
	Fri, 12 Apr 2024 00:12:18 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABD0161
	for <linux-ext4@vger.kernel.org>; Fri, 12 Apr 2024 00:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712880737; cv=none; b=k5KUnMKTOi19yCbxAi73Iks0WCCvhsMRdk+XUWe1lNXfm3EQCDdWm9tYYosdHL8t9uOFU+LMSaU4xugezqx2galRXrvRJ+5n/dOoxKkJAPh7LMm5RSxD9Ajwb5krMWL5YQqwrbz7+FVVrBrddu4r314hNiW79GnReaua6TpSFYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712880737; c=relaxed/simple;
	bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=keydOdugzFdKck6ku3rwHIsvHqmXs5CBJM8eurdKqzmFxDdScqiJaKk+sjfnS/7T1GcytI0jadyJIPBphSU8lp/WH9AcOO7ueczTVNXCgGaUOgvgL+ZrfoOvfoJ32HHHe2CtgpYQgplInlv/DrpW/gAKY2HuhjgFacmAZ0EMD20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d5e2b1cfabso35879039f.0
        for <linux-ext4@vger.kernel.org>; Thu, 11 Apr 2024 17:12:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712880736; x=1713485536;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
        b=EHVa8K8qniSqry7R9s+PCG5ifOGsmjB+Znm60zdpU3DMI3gPJVxXW7U0KUq5YwpDTK
         9PfpKM40KWtVFb17PNOhcaQUyfZ7UTFztUsBLB1o/legtPzMha/zNKrJWNN79fstTl71
         6nSLQHFWNO7AeHfeoj1UMnSPozcc72N0gvGZeCdTLsgj7sICPJ3+TqghHN/jnclTmzIf
         KNX/ppBvzseFIUXhQYe3K5QCe0dfBCaMYKifZo1RIUtnhmoRkdZeP4REvq2hSs0ziNDn
         4fWgA6pzBnwVV9+vND4negP/sHjQ1WVa8QOPX+GUWPKOp74FU7y6Po+hskGv6BhiI6QW
         ZbkA==
X-Forwarded-Encrypted: i=1; AJvYcCUfhpgq8V4PhRyhTL8ikwaqq7Llkdd0h3h3J14DY5n8e0BLA1Y9dhVSQaCnKuf7GttokLDethQMiXkJIRvJVSDEi9y6Dyw5Z1D7aA==
X-Gm-Message-State: AOJu0Yx3q643OoaI1rh1wdv1bMPR/t4/ia1pzfiPg6MNlHAuaWDSx58g
	JrXtBd0nqa2CR6TWUp0RpKfZ7jm3O5xdWdMfs5otC/O1Hq+NiOvqp0OHsMUsMeUJhG5349hL7Lx
	EY0qJGK13B8LhcrEFDViZ8+o+7t18rTeUQpyusMH9ebq7TtSY3McLx7w=
X-Google-Smtp-Source: AGHT+IGPlaDxRGtKaU/DMRiUe5PWJiF7LrwgzS8cpk8NZFl7S4weT6qQdoo/zfgG27V41YqUbOIssZBRjBGouLo6WMnLWoMak0UN
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2199:b0:36a:3f1f:bd4e with SMTP id
 j25-20020a056e02219900b0036a3f1fbd4emr65843ila.5.1712880736039; Thu, 11 Apr
 2024 17:12:16 -0700 (PDT)
Date: Thu, 11 Apr 2024 17:12:16 -0700
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d091340615db1fde@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_do_writepages
From: syzbot <syzbot+d1da16f03614058fdc48@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
ext4: fix race condition between buffer write and page_mkwrite

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos

