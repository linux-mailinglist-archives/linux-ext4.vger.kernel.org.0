Return-Path: <linux-ext4+bounces-8394-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65450AD70E0
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jun 2025 14:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 148A33A1B43
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jun 2025 12:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CC423BF91;
	Thu, 12 Jun 2025 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFe+FZAG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCE323AE7C
	for <linux-ext4@vger.kernel.org>; Thu, 12 Jun 2025 12:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749732916; cv=none; b=hgc/8CGY3rr/m7LdFKPUCaVeypPeyOIhNX+vUmpwDTmFjRmf2wULffsmmoSjsimEr2B/FBfw4m8Y84RDYwyFQF/oW1iOxHOHvQylyQ/nQol2r6JJzjavxZ5G+qCec1AOVI95KRJxoJM+apmxtTnKx5oXUBxlZTXALra2G6YfEYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749732916; c=relaxed/simple;
	bh=stH2teJpfp3w8rZAaZO7QDNg6d3e5JTfyk8Juh6i+3c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=OAwWy2qWd0QbrzYXuUkgqv7OdT4TEwVs2UZJJ7r1rZaHAuCFCaYSjFr8tZzP/RXfEo0elnsVNqFTnoWiDHm/bbjV2uCxOno2rr7lUkK8TQ/dycD0FPyY35jjPSkLCs9k+WEihuGNaH6SoqrkHOi524dL7eJ45N+SW392QCh6Pv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFe+FZAG; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-553543ddfc7so1003142e87.0
        for <linux-ext4@vger.kernel.org>; Thu, 12 Jun 2025 05:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749732912; x=1750337712; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0pPmN/RQrQMtCqgg79JhBXqoiwJt85DR4Tt/v6b7h7o=;
        b=HFe+FZAG9+ajcVM96GqG8DyB/bZFx2zUnR5O5XeIKXKDTRRtCCn5ijLa2xygVHwYxN
         mHhy+h0m/N6qCW9/ZVFL00ko/G1WDyFPus4DmLY6ZA0diQkDZOyD6IIDpP93ph2A6HMT
         6grBOPTY2AE2HBLAqshG2vrOS9CxbZ+74CrvO/n0BqV5J5Ocz+pSWPU825lzxyk/P6AY
         2p4x+n+1Mm9H54KzKCA5VXvnuj87L01U4apXsKekEjI7PV3J/JL0yNn1sr0Pb7Zn3Fpo
         KSxbitkT/NVSxJvfib8jq9P5dt+fQWcRpwwdo0UbPjH6ZAak8L+EojVqmsHCXCnrJ40d
         Gkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749732912; x=1750337712;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0pPmN/RQrQMtCqgg79JhBXqoiwJt85DR4Tt/v6b7h7o=;
        b=o6IcB1+TQNHtt/vxK95vqOcKeNKF50aJGhI4zu4kGybt/yeJoVSFhkkSa4z89zLc0+
         2Yl7jcJVbp9Zsc7NqyxtQsK80/if3x3pcLLkGODwHgxlkOp7Jaxu2GdCSAQqA8JK+5Lj
         12qkAfcNFqovSNjFjGaUuNxhbga2PpGZIw8wR3AAKsciENM3gxBZji4zyf96GiKXMb2J
         or7BqAtpTzfOO6UajE/hBRSfAmVrbzVd+0g0NKuPEgzsSvY1WxLmdunPlKo9C9JKgqp0
         7MmD3kc6u1SuWnHFpWGd9fyoBooUrxKUjYzsF9eE4o9Au7/deFVeWUh32wMf//W8P7mu
         EeXQ==
X-Gm-Message-State: AOJu0Yx7Cz18UM2iyhXOaNp/Ft3Np9CKsnINwTnxxOkFQZ1BcbewAeWV
	jvpu9s8w6gos3nnwa/6Gqf9VJqcHULfmhmjL6+eLl0TMH+WatdtRPxSUZg7rBB8Gi+N7LMdImM/
	wBJ5/dQtPuIRpHFgNJu65alAVOet+v0HUv8f8fz8=
X-Gm-Gg: ASbGncvW7T1inBL4Ul+5Axd4o1iJMxzCEKFbjMwlOHBkW4h82j7q+7yGOLCc4uFGN1Z
	Egsuz948Q90PSrMuxjSwU5ET9O/2beacCXGqlnrP+0vcJHwpfPJIlcwdZc1myTYdsloLnf9mbXg
	v52YxJ6W4BwXTYX5FBs+r9RseAEjnZmdCazxWO8GVsY2FYKZBJWpG5SkKI
X-Google-Smtp-Source: AGHT+IGFtWj97lvBIJael0fw5BqkvYdKzVqr+jXsNVlraHqjlO65A0ziHR+oJDevOACBJ7mp5KIsvmUBm8gYY2GR7dc=
X-Received: by 2002:ac2:5236:0:b0:553:a30b:ee08 with SMTP id
 2adb3069b0e04-553a30bf27amr1245779e87.14.1749732912186; Thu, 12 Jun 2025
 05:55:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Thu, 12 Jun 2025 20:54:59 +0800
X-Gm-Features: AX0GCFvaNghvdSsx2XnLQ7KfPfFndpdWHgJtdV2qPLuittrxHoUx1VOslIOnhRQ
Message-ID: <CAHB1NahGodp3=NovantwmhM2=faVWuuusfRPUiUZaXZt58K7Qg@mail.gmail.com>
Subject: Discrepancy between mkfs.ext4 man page and code on lazy_journal_init default
To: Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"

Hi,

Recently, I observed a significant difference in the number of
blk_mq_get_tag() calls when executing mkfs.ext4 -F -q /dev/$nvme
versus mkfs.ext4 -F -q -E lazy_itable_init=1,lazy_journal_init=1
/dev/$nvme. The former has over 2,000 more calls than the latter,
which is confusing because the mkfs.ext4 man page states both features
should be enabled by default. This implies the commands should be
equivalent, with no I/O difference.

       lazy_journal_init[= <0 to disable, 1 to enable>]
             If  enabled, the journal inode will not be
fully zeroed out by mke2fs.  This speeds up file system initialization
noticeably, but carries some small risk if the system crashes before
the journal has been overwritten entirely one time.  If the option
value is omitted, it defaults to 1 to enable lazy journal inode
                              ^^^^^^^^^^^
zeroing.

After examining the mkfs.ext4 source code, I found lazy_journal_init
is not enabled by default. The relevant snippet is:
       journal_flags |= get_bool_from_profile(fs_types,
                                     "lazy_journal_init", 0) ?
                                      EXT2_MKJOURNAL_LAZYINIT : 0;

Here, the default value passed to get_bool_from_profile is 0  , and
/etc/mke2fs.conf lacks lazy_journal_init configuration.
         root:~/e2fsprogs/build# grep lazy_journal_init /etc/mke2fs.conf
         root:~/e2fsprogs/build#

This behavior dates back to a 14-year-old commit 6c54689fadc3,
"mke2fs: skip zeroing journal blocks", contradicting the man page
explicitly.

Am I missing a configuration detail, or is this a genuine
documentation-code discrepancy? If the latter, I'm happy to submit a
patch to resolve it.

Any insights are much appreciated. Looking forward to your response.

ps:
root:~/e2fsprogs/build# mkfs.ext4 -V
mke2fs 1.47.3-rc1 (28-May-2025)
           Using EXT2FS Library version 1.47.3-rc1

Thanks,
-- 
Julian Sun <sunjunchao2870@gmail.com>

