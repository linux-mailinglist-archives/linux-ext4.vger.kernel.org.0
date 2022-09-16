Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419AC5BAED7
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Sep 2022 16:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbiIPOEr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Sep 2022 10:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiIPOEq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Sep 2022 10:04:46 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0964E2735
        for <linux-ext4@vger.kernel.org>; Fri, 16 Sep 2022 07:04:42 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MTbNN5jsdznVFd;
        Fri, 16 Sep 2022 22:01:56 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 16 Sep
 2022 22:04:40 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <linux-ext4@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v3 00/16] some refactor of __ext4_fill_super()
Date:   Fri, 16 Sep 2022 22:15:11 +0800
Message-ID: <20220916141527.1012715-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This function is maybe the longest function I have seen in the kernel.
It has more than one thousand lines. This makes us not easy to read and
understand the code. So I made some refactors. The first two patches did
some preparation to the goto labels so that we can factor out some
functions easily.

After this refactor this function is about 500 lines shorter. I did not
go further because I'm not sure if people like this kind of change. If
there is any bad side effects, please let me know. If you strongly
dislike it, I am ok to stop this refactor.

v2->v3:
  Patch #7 define a null function when CONFIG_UNICODE is not enabled.
  Add patch #14~16 to unify super block loading and move DIOREAD_NOLOCK
      setting to ext4_set_def_opts().
  Add some reviewed-by tags from Ritesh.

v1->v2: 
  some code improvements suggested by Jan Kara and add review tags.

Jason Yan (16):
  ext4: goto right label 'failed_mount3a'
  ext4: remove cantfind_ext4 error handler
  ext4: factor out ext4_set_def_opts()
  ext4: factor out ext4_handle_clustersize()
  ext4: factor out ext4_fast_commit_init()
  ext4: factor out ext4_inode_info_init()
  ext4: factor out ext4_encoding_init()
  ext4: factor out ext4_init_metadata_csum()
  ext4: factor out ext4_check_feature_compatibility()
  ext4: factor out ext4_geometry_check()
  ext4: factor out ext4_group_desc_init() and ext4_group_desc_free()
  ext4: factor out ext4_load_and_init_journal()
  ext4: factor out ext4_journal_data_mode_check()
  ext4: unify the ext4 super block loading operation
  ext4: remove useless local variable 'blocksize'
  ext4: move DIOREAD_NOLOCK setting to ext4_set_def_opts()

 fs/ext4/super.c | 1213 ++++++++++++++++++++++++++---------------------
 1 file changed, 685 insertions(+), 528 deletions(-)

-- 
2.31.1

