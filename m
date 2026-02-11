Return-Path: <linux-ext4+bounces-13670-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKx8Jy9UjGnblAAAu9opvQ
	(envelope-from <linux-ext4+bounces-13670-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Feb 2026 11:04:31 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C746123227
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Feb 2026 11:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3250B304A5AD
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Feb 2026 10:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8252335EDCD;
	Wed, 11 Feb 2026 10:03:05 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFF0366821
	for <linux-ext4@vger.kernel.org>; Wed, 11 Feb 2026 10:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770804185; cv=none; b=oMzePivRpPeIrqpZ/Yd193MP4khjPXFjn6er/W/8GYTfll0s4fTk0sW+NTpGslygpJxDhDNTpYbsD7aJyL705L2dxHyVaaDos8sHFrJoOyMjyVDFu4A0hD4wzuR2wIOv85SsNoWL2vgzaQSka7bbBLM/KQX9gwMVz1dLK1O56P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770804185; c=relaxed/simple;
	bh=ZMrG51+mQkHm1Kq5wEi+CO9I460GVEQNML+q6XKrnpc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=H02NqQcyyHb/6mmJujI/UdE/EEgu8+Xvve0uRUB0NCPcrNApOvHU4nhqCT0ASUPcJrW1Zea3zlOk/cQKahD0SOI4DGrTQFZ8Ub92MfGRWIiiaHncZudj7qB7qjc3Xn/TbauB+YsBzhBgxo3bWqRY2HkaLd/19T/DZUJwjtAjSRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-4097bb790e5so3792872fac.1
        for <linux-ext4@vger.kernel.org>; Wed, 11 Feb 2026 02:03:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770804182; x=1771408982;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3okMtziSuPBmLgCGeJXkzA55zTmCiq1DIP/2hspFEYc=;
        b=fihPCG7r+De+GKe/Y+craHx3s+hgHT2tsues/EDQq238DZerh88dJbTs670SzZ4Eqj
         JIHqNQUboqjsuw6YE2XRanVdgGWpbxvuUD/42ywIcbvpUSIloQI+antr2Xy6qPiRw6a2
         y3d/Kl0A2lRBRqoQMIR/yqAbdQE6rg5GZEKbVB6fvbGeAXRqB94ksx8cv1DuWpUeXrOY
         0djNUPs4zn1U359qE1nykex/NFutQdn6ugmiNjxfig4wnekcIWsSVPi2S8E1gBM3+/w3
         A/5NQVV6iWY4IhKrILuwznxm25PdOLOjyFiTMq30VAHFjYgBVhuQ9avtFkVGG96F8bGr
         u9uw==
X-Forwarded-Encrypted: i=1; AJvYcCXC308ob//LApexw2JGgP3gh4asYsVArqungHKtUW1uOCh91csIQA1iEkeSPBfSGlS6dYFbtYttCn9i@vger.kernel.org
X-Gm-Message-State: AOJu0YyuOKL5serk5seLEJxTdMDji+7SJD4pLHz9CsuOvE1/GdFR+BtD
	gdx7NAoxvsCI8pipS3uoc1520hqs5G2c9VqMxrSRTHW9OTmsWwnvYQ4d4UZvm2xnC/YIW+JdaEJ
	/5rdHPGArLPBpdLYShlr0Z6m3hOauMEIsagzTG4nWrN1QctBMKK+My4jPD6A=
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:e918:0:b0:66b:71c9:9be4 with SMTP id
 006d021491bc7-672e5cdb931mr2539255eaf.25.1770804182487; Wed, 11 Feb 2026
 02:03:02 -0800 (PST)
Date: Wed, 11 Feb 2026 02:03:02 -0800
In-Reply-To: <aYw97hffWIoiQQGH@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <698c53d6.050a0220.340abe.000c.GAE@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_es_cache_extent (4)
From: syzbot <syzbot+ccf1421545dbe5caa20c@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=a535ad5429f72a2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13670-lists,linux-ext4=lfdr.de,ccf1421545dbe5caa20c];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 3C746123227
X-Rspamd-Action: no action

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ccf1421545dbe5caa20c@syzkaller.appspotmail.com
Tested-by: syzbot+ccf1421545dbe5caa20c@syzkaller.appspotmail.com

Tested on:

commit:         4f5e8e6f et4: allow zeroout when doing written to unwr..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
console output: https://syzkaller.appspot.com/x/log.txt?x=17815b22580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a535ad5429f72a2
dashboard link: https://syzkaller.appspot.com/bug?extid=ccf1421545dbe5caa20c
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=120cccaa580000

Note: testing is done by a robot and is best-effort only.

