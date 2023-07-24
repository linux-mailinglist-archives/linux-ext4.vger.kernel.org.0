Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8213C75F28F
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jul 2023 12:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjGXKQ3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Jul 2023 06:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbjGXKQL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Jul 2023 06:16:11 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7421FCA
        for <linux-ext4@vger.kernel.org>; Mon, 24 Jul 2023 03:08:07 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-63cff212c0dso1165906d6.1
        for <linux-ext4@vger.kernel.org>; Mon, 24 Jul 2023 03:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690193283; x=1690798083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PA74NunQFszlW8RpIb5KtNwL3Pn/7Z7EgMABUrgFylU=;
        b=LtaGdXvsk3nDwgJPI0tBkuRGd2S1RLJ0EPSiQy6iYvZ/knWm0D9ksis51e9W8iMXCp
         oBSLYcL6f9Las/iCNcfMnrxpbbmXwdBHfwkQtOuBfHeutd5zGiOlk6SYZviWl31UAfy9
         EqOHFXY2Ltqp64lSZlsrl8Yk9IK4rrDD6MG6hhrKpx4Y3plba9Ya/EkOPy63qNBF+df+
         P3QwAMwlVgj5BXjRJ6BB2PzS/TeFTypNAfsP8B0pkvnngG52nZYqRSEzuh405we6s2QB
         /D2w28ShRkU3DtYP5YLRB/Dn+lewVT5Wz2DVO35quIJHJANMelTmGUc9AkvYbrxLk7gz
         A8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690193283; x=1690798083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PA74NunQFszlW8RpIb5KtNwL3Pn/7Z7EgMABUrgFylU=;
        b=Amx/Fp+qy0FxZa5WPYCL5ibi/Kk9DfD1BkvFVDMi4oMQDEGpCgVWlG/aTxwMaFFa5f
         W0zZ+zCf0H48zxRiZ81YYJKarELN7TUBBE01+4U2r23/MtpO/YynAgON1hQwbAcB1SDS
         g74SHcEQy3nNFlzLpyqzZACL9Q8HI9ltF3fNq1zdU3/4ayjM87C6N/yD8LRIb0DHqyc6
         axoK/MWkPOfBQ9/yVv1rDp+JYDEgZRABaCJcu0dRQNMKrfEd23P16/Dn4ORCGrWOYAul
         YAAsqiSbExCmWThmWlAkVq9WZkYJdv4L+tNn6YM4n3PZ0tpzzcIocuIY54emsaX8RKsF
         z4ww==
X-Gm-Message-State: ABy/qLZiB2tKZdzN1tW6U4UE1BeZm4S2/uf3lpKvPfJ0j0KTzLxORswh
        P5IEvTbEqBFkehudUAygDzymK79wDb43MH3Sr7U=
X-Google-Smtp-Source: APBJJlG2oOvKNbqCVYKCsLLrFI6N3Peh10WK+D3LiX3VUR0Gh2vD9sbZ8AKvOgxEZEiSv+Xi5/CKrg==
X-Received: by 2002:a17:902:d4cb:b0:1b1:9272:55e2 with SMTP id o11-20020a170902d4cb00b001b1927255e2mr12377128plg.3.1690192313997;
        Mon, 24 Jul 2023 02:51:53 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001bb20380bf2sm8467233pld.13.2023.07.24.02.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:51:53 -0700 (PDT)
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
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 34/47] nfsd: dynamically allocate the nfsd-client shrinker
Date:   Mon, 24 Jul 2023 17:43:41 +0800
Message-Id: <20230724094354.90817-35-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the nfsd-client shrinker, so that it can be freed
asynchronously using kfree_rcu(). Then it doesn't need to wait for RCU
read-side critical section when releasing the struct nfsd_net.

Acked-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 fs/nfsd/netns.h     |  2 +-
 fs/nfsd/nfs4state.c | 20 ++++++++++++--------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index ec49b200b797..f669444d5336 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -195,7 +195,7 @@ struct nfsd_net {
 	int			nfs4_max_clients;
 
 	atomic_t		nfsd_courtesy_clients;
-	struct shrinker		nfsd_client_shrinker;
+	struct shrinker		*nfsd_client_shrinker;
 	struct work_struct	nfsd_shrinker_work;
 };
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 3339177f8e2f..c7a4616cd866 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4388,8 +4388,7 @@ static unsigned long
 nfsd4_state_shrinker_count(struct shrinker *shrink, struct shrink_control *sc)
 {
 	int count;
-	struct nfsd_net *nn = container_of(shrink,
-			struct nfsd_net, nfsd_client_shrinker);
+	struct nfsd_net *nn = shrink->private_data;
 
 	count = atomic_read(&nn->nfsd_courtesy_clients);
 	if (!count)
@@ -8125,12 +8124,17 @@ static int nfs4_state_create_net(struct net *net)
 	INIT_WORK(&nn->nfsd_shrinker_work, nfsd4_state_shrinker_worker);
 	get_net(net);
 
-	nn->nfsd_client_shrinker.scan_objects = nfsd4_state_shrinker_scan;
-	nn->nfsd_client_shrinker.count_objects = nfsd4_state_shrinker_count;
-	nn->nfsd_client_shrinker.seeks = DEFAULT_SEEKS;
-
-	if (register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client"))
+	nn->nfsd_client_shrinker = shrinker_alloc(0, "nfsd-client");
+	if (!nn->nfsd_client_shrinker)
 		goto err_shrinker;
+
+	nn->nfsd_client_shrinker->scan_objects = nfsd4_state_shrinker_scan;
+	nn->nfsd_client_shrinker->count_objects = nfsd4_state_shrinker_count;
+	nn->nfsd_client_shrinker->seeks = DEFAULT_SEEKS;
+	nn->nfsd_client_shrinker->private_data = nn;
+
+	shrinker_register(nn->nfsd_client_shrinker);
+
 	return 0;
 
 err_shrinker:
@@ -8228,7 +8232,7 @@ nfs4_state_shutdown_net(struct net *net)
 	struct list_head *pos, *next, reaplist;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	unregister_shrinker(&nn->nfsd_client_shrinker);
+	shrinker_unregister(nn->nfsd_client_shrinker);
 	cancel_work(&nn->nfsd_shrinker_work);
 	cancel_delayed_work_sync(&nn->laundromat_work);
 	locks_end_grace(&nn->nfsd4_manager);
-- 
2.30.2

