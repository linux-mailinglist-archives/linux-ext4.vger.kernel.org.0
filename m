Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53076C6A76
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Mar 2023 15:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjCWOI1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Mar 2023 10:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjCWOIU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Mar 2023 10:08:20 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC4510A99
        for <linux-ext4@vger.kernel.org>; Thu, 23 Mar 2023 07:07:01 -0700 (PDT)
Received: from canpemm100004.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Pj6Wl65PTz17LMp;
        Thu, 23 Mar 2023 22:03:47 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm100004.china.huawei.com
 (7.192.105.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 23 Mar
 2023 22:06:55 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <linux-ext4@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH 0/8] some refactor of __ext4_fill_super(), part 2.
Date:   Thu, 23 Mar 2023 22:05:09 +0800
Message-ID: <20230323140517.1070239-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm100004.china.huawei.com (7.192.105.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is a continuous effort to make __ext4_fill_super() shorter and more
readable. The previous work is here[1]. I'm using my spare time to do this
work so it's a bit late after the previous series.

[1] http://patchwork.ozlabs.org/project/linux-ext4/cover/20220916141527.1012715-1-yanaijie@huawei.com/

Jason Yan (8):
  ext4: factor out ext4_hash_info_init()
  ext4: factor out ext4_percpu_param_init() and
    ext4_percpu_param_destroy()
  ext4: use ext4_group_desc_free() in ext4_put_super() to save some
    duplicated code
  ext4: factor out ext4_flex_groups_free()
  ext4: rename two functions with 'check'
  ext4: move s_reserved_gdt_blocks and addressable checking into
    ext4_check_geometry()
  ext4: factor out ext4_block_group_meta_init()
  ext4: move dax and encrypt checking into
    ext4_check_feature_compatibility()

 fs/ext4/super.c | 392 ++++++++++++++++++++++++++----------------------
 1 file changed, 209 insertions(+), 183 deletions(-)

-- 
2.31.1

