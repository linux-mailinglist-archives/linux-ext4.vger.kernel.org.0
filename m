Return-Path: <linux-ext4+bounces-13678-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APo5NeCxjGlLsQAAu9opvQ
	(envelope-from <linux-ext4+bounces-13678-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Feb 2026 17:44:16 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA91C126451
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Feb 2026 17:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B1032300609F
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Feb 2026 16:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C0C25DAEA;
	Wed, 11 Feb 2026 16:44:07 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793D234321F
	for <linux-ext4@vger.kernel.org>; Wed, 11 Feb 2026 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770828247; cv=none; b=MUgR2CtJEOYyswrxMAa96Ya9EI/wZrvwtxfob9CuoWG6j72s7l8FzcnMtb52KXHWj93/En22kLQyZ48bqBA9Cc/V5tSDQW0h+cAvYOvPQl1PVpB0YsWKL/7fxpgGiakuh3TQTeToLPJC44Wg+oxXoFrSX7MVr/u94tqnW9LU7KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770828247; c=relaxed/simple;
	bh=5LtN9d3s+erlZIc5bvxk2tLbSYgvjChkf3HmrSn+GdM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EkrL1JSPvProDZ/rMc6jA7rFKssztDCIwYk1W+WVZFNXjDgenQ4/XKbnroAr6YFdh73YLtMY8ncnw2p33ZUYkkP4NVP7iT6ruKVIJgw+OlE5upkI7S1oIQIuU6cKNkwaOAz+hxalKEmDF7YGZ25SzB9gAMJnsnAtjW1OLjR80+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-662ff11fff8so30740974eaf.3
        for <linux-ext4@vger.kernel.org>; Wed, 11 Feb 2026 08:44:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770828243; x=1771433043;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PkcI7VuLfb23NVv22965AH/dq+DBA1lXNER+M9UwYII=;
        b=PeneZskDYczVJfvTRnruGJ/zGWdg8Wb9nx3O6CsNHUhdH4K3c/uAzSORxJUTnpEbY3
         U3Wy+IcKBVf12XD0UPuwTypRooLWGWC9hmHZEChaipHfUY1eJgP+bBIrn2a8i7iqpxM9
         4oSVCgSEpDILkcT7qU7aC9+IiSf8gW5vpwvvKO/Jg0pakcwUaDrFDlPBn2vPs0UYI3+i
         ryeeS8Cg95+kOKjoxOai/3lUSOCISJDU1z2s6eAh4xoXI4t1kZaw/pKrucCHXqfyPZ8k
         UX6LnndBwukgTV1NhC+crZjb04r4I8jNdoDPHh/JeNEoChRhSIQXdpLNyY4jwNoN/9Ep
         Kvcg==
X-Gm-Message-State: AOJu0Yyek+Uozrb5F3Vk3SFiRAlpphYBNQqsTvkEj4tg0Ae4dvbwsiLh
	QwlB+uyk2SO+6IaFC1pCQCGNPtb3d/efXQFOln4ehv9AJiklmKU+kgAEUkGEbB148Fd4N5XTUGc
	CrrUIVRRDPUpX72QeBM5hoaK8SU2oV7YvDlX+eO/82ExnBGcVRZor7ASrQbo=
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4589:b0:66e:d87a:2323 with SMTP id
 006d021491bc7-6747f37ec17mr918156eaf.11.1770828243240; Wed, 11 Feb 2026
 08:44:03 -0800 (PST)
Date: Wed, 11 Feb 2026 08:44:03 -0800
In-Reply-To: <aYyHV-wPS0UrL59y@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <698cb1d3.a70a0220.2c38d7.0084.GAE@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_es_cache_extent (4)
From: syzbot <syzbot+ccf1421545dbe5caa20c@syzkaller.appspotmail.com>
To: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ojaswin@linux.ibm.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=a535ad5429f72a2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13678-lists,linux-ext4=lfdr.de,ccf1421545dbe5caa20c];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DA91C126451
X-Rspamd-Action: no action

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ccf1421545dbe5caa20c@syzkaller.appspotmail.com
Tested-by: syzbot+ccf1421545dbe5caa20c@syzkaller.appspotmail.com

Tested on:

commit:         4f5e8e6f et4: allow zeroout when doing written to unwr..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
console output: https://syzkaller.appspot.com/x/log.txt?x=15aece5a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a535ad5429f72a2
dashboard link: https://syzkaller.appspot.com/bug?extid=ccf1421545dbe5caa20c
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=166e8e5a580000

Note: testing is done by a robot and is best-effort only.

