Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B700D5E97E0
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Sep 2022 04:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiIZCU1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 25 Sep 2022 22:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiIZCU0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 25 Sep 2022 22:20:26 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EAD2529A
        for <linux-ext4@vger.kernel.org>; Sun, 25 Sep 2022 19:20:24 -0700 (PDT)
Received: from canpemm500008.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MbRFb6DL0zWgtX;
        Mon, 26 Sep 2022 10:16:19 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500008.china.huawei.com
 (7.192.105.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 26 Sep
 2022 10:20:22 +0800
From:   Li Jinlin <lijinlin3@huawei.com>
To:     <lijinlin3@huawei.com>
CC:     <adilger@whamcloud.com>, <linfeilong@huawei.com>,
        <linux-ext4@vger.kernel.org>, <liuzhiqiang26@huawei.com>,
        <tytso@mit.edu>
Subject: Re: [PATCH] tune2fs: exit directly when fs freed in ext2fs_run_ext3_journal
Date:   Mon, 26 Sep 2022 17:46:49 +0800
Message-ID: <20220926094649.1784658-1-lijinlin3@huawei.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220916074223.8885-1-lijinlin3@huawei.com>
References: <20220916074223.8885-1-lijinlin3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500008.china.huawei.com (7.192.105.151)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

friendly ping ...

Thanks,
Jinlin
