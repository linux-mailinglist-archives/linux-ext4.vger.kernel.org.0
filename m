Return-Path: <linux-ext4+bounces-14291-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJ1JHgFmpGlcfgUAu9opvQ
	(envelope-from <linux-ext4+bounces-14291-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sun, 01 Mar 2026 17:14:57 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BAC1D08EC
	for <lists+linux-ext4@lfdr.de>; Sun, 01 Mar 2026 17:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56A82301300D
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Mar 2026 16:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D453930F7F3;
	Sun,  1 Mar 2026 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ai/8D3s8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FCA2DCF6C
	for <linux-ext4@vger.kernel.org>; Sun,  1 Mar 2026 16:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772381692; cv=none; b=cMmJn2dIgCABRMD7HoLhxTb4IJSs/bUDe4rLyu8P/sxT+xksRQB0Sq0hg8Kd93rX7SMPvbYbBKdhJwjnESF6oZWcC8xvKH6MzQ7qemgQLwE8StqrxTqwpDu0uujGcfn9QE4HAkl5SJK6e4ucoDXZ6jJzzxlzU7IqDFWT3yzUHOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772381692; c=relaxed/simple;
	bh=Eno1iht+PVmmfWUYzGsnifDO+DdWBQEKNZ3MtxWnXbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oh6lSMnXTUnYgs2lU40Lf2+uU1mfplBWeRXTaYoiLwR35l4gMbCnZhuZYWyeDg7SMVEEY1w1WsdpVvTpSrDYZmxYzLVMRhvpzJWzJJH9B4ft4Ee890EYVEYkzdkcURFG4+N1pBwaWgAExmHAjDcsti4e/HeaNwWfWE1RE7HsLYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ai/8D3s8; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-824ba8f0acaso1857210b3a.1
        for <linux-ext4@vger.kernel.org>; Sun, 01 Mar 2026 08:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772381690; x=1772986490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JvS7TZbJuLBE+k3dJSuAN7AJazKrzDmLDkhxnSkZZWA=;
        b=Ai/8D3s8B7jY07QIfqP+9gYC351rcF6PtVkKnLQEvrFyF9LbhYT1fBO1rrmsOSOkq4
         QH8pEkS84H00Y5KtjL7h2tHptT3Ir3N6UzYZXQ8B1IMwDcUcYEXtvAkonfgvoTi77uk7
         OxzVAD6HdE8KrbUoRm0RZcOsj/F9S0DOwRZIOraDNsY/vM+s5wr1NpjhhtoL7eTgcyXR
         IWcAj67Rc4azTpqbLpO4X3zfmmWvRzA8jviFWknJA32203llbInLyivBySQdENu1qyqF
         5FpYGup3Iu7la2CmInWzBge2z/AyjuxCfyfcKczRB2m49xweFZv2h5+dVSvssqk6qJWU
         Iy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772381690; x=1772986490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvS7TZbJuLBE+k3dJSuAN7AJazKrzDmLDkhxnSkZZWA=;
        b=PzEur2DrE4meB0bP1wUuDZSc+X4g0BGCiqPa/1J/Pu9iDIfRZKSrkcLxTFojOAiE3P
         gGe2kQrmlpMqQs0p9Cbzb5WC58I7fpD/kJlb+nzAy9OLkI/bxloq/OILwPCjRdzhTP0e
         XGn+vCgsUg7pjAAbxVBJdRu6D5fD4s7R9Mat4qLiIsFsVaMVfcaWRMswnZF32YpSCKuz
         hBJOm9rCB3V+HCPmcD+VhICBlNE3hXbMj6rJj7/rykoKkX+1zGVBMxCR0gxUSIEl+H7W
         UiknzWN5FCaQ4W3vlMdSNiUJqHyBc+RnWnVNqnHzQVsHL7k0yO2dgDruKuqNqdtRRGZC
         18vw==
X-Gm-Message-State: AOJu0Yzfe8xi7SIyfi6a5WP+/PznYu7a0f36XkQ3FY0UwmQ6jt9I6Dgj
	xvOADTEnub36ZAaA9sQ0Ur+kkTOK/2XqTnKDxj7XNFYedO3MxdLTj7D8L+A9lA==
X-Gm-Gg: ATEYQzyblNoz/qXMV6DyQfC/jWj4/FhMrjKohyXdNXPt/YpCjeKlSVYaYy5VyRBIYRV
	9LwWC+Xxxdjr0hMsiRBHSJstvntNjl8h4Jb1wYRa4dtg1J0H9HHnmdBDdJc5Iqjb7gxxXeUVqi7
	VZxvzbUpcdpZRwpJEX4nMNe4uL4POvV61zJ+PM6mGkqFSmOJr4dPGIV0SH+FFoW3aEvO0UbVho5
	Y5PdObINQ477cqTB8IIlTjK5D2RSWSmtgg6js3FNbmoBMpGeDxNh5326SqXVwJ60dgUXk24A2KD
	Kik5QITNOJ/DAYE2fn5Op0VQz7lOz4gEzvRpp+JtBm48CrRhvi3Gk3nev8jxBQn8cp3z7jiaH/h
	9dGM92QCx3Owp8MBVrfeHMZHeOg1BJRpMUNYw9lRIjdCGMJkIDFXKtBA5bLI3qSouZfI43EtBuU
	tUsK/63MIORIigSCvLL2eiJbgN7lFLuA==
X-Received: by 2002:a05:6a00:1c8e:b0:827:3f79:2349 with SMTP id d2e1a72fcca58-8274da2a016mr8746149b3a.61.1772381689990;
        Sun, 01 Mar 2026 08:14:49 -0800 (PST)
Received: from dw-tp.ibmuc.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739dabd43sm12428765b3a.25.2026.03.01.08.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 08:14:49 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH] ext4: kunit: extents-test: Fix percpu_counters list corruption
Date: Sun,  1 Mar 2026 21:44:26 +0530
Message-ID: <5bb9041471dab8ce870c191c19cbe4df57473be8.1772381213.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14291-lists,linux-ext4=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.ibm.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[riteshlist@gmail.com,linux-ext4@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-ext4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E6BAC1D08EC
X-Rspamd-Action: no action

commit 82f80e2e3b23 ("ext4: add extent status cache support to kunit tests"),
added ext4_es_register_shrinker() in extents_kunit_init() function but
failed to add the unregister shrinker routine in extents_kunit_exit().

This could cause the following percpu_counters list corruption bug.

         ok 1 split unwrit extent to 2 extents and convert 1st half writ
  slab kmalloc-4k start c0000002007ff000 pointer offset 1448 size 4096
 list_add corruption. next->prev should be prev (c000000004bc9e60), but was 0000000000000000. (next=c0000002007ff5a8).
 ------------[ cut here ]------------
 kernel BUG at lib/list_debug.c:29!
cpu 0x2: Vector: 700 (Program Check) at [c000000241927a30]
    pc: c000000000f26ed0: __list_add_valid_or_report+0x120/0x164
    lr: c000000000f26ecc: __list_add_valid_or_report+0x11c/0x164
    sp: c000000241927cd0
   msr: 800000000282b033
  current = 0xc000000241215200
  paca    = 0xc0000003fffff300   irqmask: 0x03   irq_happened: 0x09
    pid   = 258, comm = kunit_try_catch
kernel BUG at lib/list_debug.c:29!
enter ? for help
 __percpu_counter_init_many+0x148/0x184
 ext4_es_register_shrinker+0x74/0x23c
 extents_kunit_init+0x100/0x308
 kunit_try_run_case+0x78/0x1f8
 kunit_generic_run_threadfn_adapter+0x40/0x70
 kthread+0x190/0x1a0
 start_kernel_thread+0x14/0x18
2:mon>

This happens because:

extents_kunit_init(test N):
  ext4_es_register_shrinker(sbi)
    percpu_counters_init() x 4; // this adds 4 list nodes to global percpu_counters list
      list_add(&fbc->list, &percpu_counters);
    shrinker_register();

extents_kunit_exit(test N):
  kfree(sbi);			// frees sbi w/o removing those 4 list nodes.
  				// So, those list node now becomes dangling pointers

extents_kunit_init(test N+1):
  kzalloc_obj(ext4_sb_info)	// allocator returns same page, but zeroed.
  ext4_es_register_shrinker(sbi)
    percpu_counters_init()
      list_add(&fbc->list, &percpu_counters);
        __list_add_valid(new, prev, next);
	next->prev != prev 		// list corruption bug detected, since next->prev = NULL

Fixes: 82f80e2e3b23 ("ext4: add extent status cache support to kunit tests")
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/extents-test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents-test.c b/fs/ext4/extents-test.c
index 7c4690eb7dad..a6b3e6b592a5 100644
--- a/fs/ext4/extents-test.c
+++ b/fs/ext4/extents-test.c
@@ -142,8 +142,10 @@ static struct file_system_type ext_fs_type = {

 static void extents_kunit_exit(struct kunit *test)
 {
-	struct ext4_sb_info *sbi = k_ctx.k_ei->vfs_inode.i_sb->s_fs_info;
+	struct super_block *sb = k_ctx.k_ei->vfs_inode.i_sb;
+	struct ext4_sb_info *sbi = sb->s_fs_info;

+	ext4_es_unregister_shrinker(sbi);
 	kfree(sbi);
 	kfree(k_ctx.k_ei);
 	kfree(k_ctx.k_data);
--
2.53.0


