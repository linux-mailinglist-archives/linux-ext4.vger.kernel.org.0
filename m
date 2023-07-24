Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD97375F1D0
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jul 2023 12:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbjGXKCI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Jul 2023 06:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjGXKBW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Jul 2023 06:01:22 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3B465AB
        for <linux-ext4@vger.kernel.org>; Mon, 24 Jul 2023 02:54:45 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1bba9539a23so649945ad.1
        for <linux-ext4@vger.kernel.org>; Mon, 24 Jul 2023 02:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690192362; x=1690797162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+msSROnlHTbkN8WdS5VhxMSS48DaBcuNUu675bILAm8=;
        b=h3gsG4QXWw/nahqBxLdBCvqi4m8rD0FXz9A20d9YDr1GVweA7QI5gIYRXxeR03F7VF
         avO+YUz8f1IL6J1uYX1/b0NEPW6FiLuYcPPgWc9sNeFYAy1/jQVonTK3Har+aojJwTqi
         hQZEwnSV3LL7ecl9UfamsDpZO40zuTjDqPfF5eu13La0YtcWt3KQO54XvrgMZueVi5PZ
         X9MwcigdTTnwiJ3xQrZgNRbLcfkBdWK7eRH096K0D7h66kc666JHvNvIGlIc1vw99tH0
         GAm/hWRvtDUBnuyuOUfh8qzrbwzBKl3sPPd+rGOKnxJaCrXEUUZmWLLd6RNa7iYZg14F
         z6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690192362; x=1690797162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+msSROnlHTbkN8WdS5VhxMSS48DaBcuNUu675bILAm8=;
        b=fRd84dL7d5preyXopJaV6Fb93bxzKuPL2y6ASpEgjqPSVaWx3uYSYdNDKq06IRZgLr
         7D8JJkSt3TKrJTYMX7If8k301WLAj8vJxTVPK4HUOS0I3nAWNhtV2DJi2OIG/xlJGEC9
         BXzIfzizPyNhK6M0ViGmfaipcndW4rYI9r1P35AftigdMjUt1Z4B0oV+mR/Mw/1qB8Fv
         4nMIbRYvhIA8gtPGZd27KJ5ecHp73qbs67byQ8CBv57XKC2x/Jd6XdSwfkiEkWCIQDhu
         GC/AvevljNE9jI9QNq41qGeE0OLZe+LySE21PjZ280nw9USpMKVQc98//jFq8EL//KoG
         ZbgQ==
X-Gm-Message-State: ABy/qLbtFUPI5Eju/PYv0BLT5TtWwaD29lbuuBUT/NFqx6ZjfBk/qAxP
        qstHCmB0abqfNMvvdso9Mo+UbQ==
X-Google-Smtp-Source: APBJJlFjFnMUMe3SYJatR/saB9KY/jkISOdIPz1PLzDLS3adgTzHCnV8/bXf0D4q3OfiSxgFenVrMg==
X-Received: by 2002:a17:903:41c9:b0:1b8:17e8:547e with SMTP id u9-20020a17090341c900b001b817e8547emr12208099ple.1.1690192361964;
        Mon, 24 Jul 2023 02:52:41 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001bb20380bf2sm8467233pld.13.2023.07.24.02.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:52:41 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 38/47] xfs: dynamically allocate the xfs-qm shrinker
Date:   Mon, 24 Jul 2023 17:43:45 +0800
Message-Id: <20230724094354.90817-39-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the xfs-qm shrinker, so that it can be freed
asynchronously using kfree_rcu(). Then it doesn't need to wait for RCU
read-side critical section when releasing the struct xfs_quotainfo.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 fs/xfs/xfs_qm.c | 26 +++++++++++++-------------
 fs/xfs/xfs_qm.h |  2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
index 6abcc34fafd8..8f1216e1efc1 100644
--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -504,8 +504,7 @@ xfs_qm_shrink_scan(
 	struct shrinker		*shrink,
 	struct shrink_control	*sc)
 {
-	struct xfs_quotainfo	*qi = container_of(shrink,
-					struct xfs_quotainfo, qi_shrinker);
+	struct xfs_quotainfo	*qi = shrink->private_data;
 	struct xfs_qm_isolate	isol;
 	unsigned long		freed;
 	int			error;
@@ -539,8 +538,7 @@ xfs_qm_shrink_count(
 	struct shrinker		*shrink,
 	struct shrink_control	*sc)
 {
-	struct xfs_quotainfo	*qi = container_of(shrink,
-					struct xfs_quotainfo, qi_shrinker);
+	struct xfs_quotainfo	*qi = shrink->private_data;
 
 	return list_lru_shrink_count(&qi->qi_lru, sc);
 }
@@ -680,16 +678,18 @@ xfs_qm_init_quotainfo(
 	if (XFS_IS_PQUOTA_ON(mp))
 		xfs_qm_set_defquota(mp, XFS_DQTYPE_PROJ, qinf);
 
-	qinf->qi_shrinker.count_objects = xfs_qm_shrink_count;
-	qinf->qi_shrinker.scan_objects = xfs_qm_shrink_scan;
-	qinf->qi_shrinker.seeks = DEFAULT_SEEKS;
-	qinf->qi_shrinker.flags = SHRINKER_NUMA_AWARE;
-
-	error = register_shrinker(&qinf->qi_shrinker, "xfs-qm:%s",
-				  mp->m_super->s_id);
-	if (error)
+	qinf->qi_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE, "xfs-qm:%s",
+					   mp->m_super->s_id);
+	if (!qinf->qi_shrinker)
 		goto out_free_inos;
 
+	qinf->qi_shrinker->count_objects = xfs_qm_shrink_count;
+	qinf->qi_shrinker->scan_objects = xfs_qm_shrink_scan;
+	qinf->qi_shrinker->seeks = DEFAULT_SEEKS;
+	qinf->qi_shrinker->private_data = qinf;
+
+	shrinker_register(qinf->qi_shrinker);
+
 	return 0;
 
 out_free_inos:
@@ -718,7 +718,7 @@ xfs_qm_destroy_quotainfo(
 	qi = mp->m_quotainfo;
 	ASSERT(qi != NULL);
 
-	unregister_shrinker(&qi->qi_shrinker);
+	shrinker_unregister(qi->qi_shrinker);
 	list_lru_destroy(&qi->qi_lru);
 	xfs_qm_destroy_quotainos(qi);
 	mutex_destroy(&qi->qi_tree_lock);
diff --git a/fs/xfs/xfs_qm.h b/fs/xfs/xfs_qm.h
index 9683f0457d19..d5c9fc4ba591 100644
--- a/fs/xfs/xfs_qm.h
+++ b/fs/xfs/xfs_qm.h
@@ -63,7 +63,7 @@ struct xfs_quotainfo {
 	struct xfs_def_quota	qi_usr_default;
 	struct xfs_def_quota	qi_grp_default;
 	struct xfs_def_quota	qi_prj_default;
-	struct shrinker		qi_shrinker;
+	struct shrinker		*qi_shrinker;
 
 	/* Minimum and maximum quota expiration timestamp values. */
 	time64_t		qi_expiry_min;
-- 
2.30.2

