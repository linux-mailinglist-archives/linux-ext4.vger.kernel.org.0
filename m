Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C4E5501EB
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Jun 2022 04:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383832AbiFRCMu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Jun 2022 22:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383868AbiFRCMt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Jun 2022 22:12:49 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2683EAB;
        Fri, 17 Jun 2022 19:12:44 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25I2CDbC005828
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jun 2022 22:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1655518336; bh=llEB8Cqtjsb22Kk1jdXgp0Ij2VN1THOeEhNwPZBirjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SQ8jOdXxutslKMRZO1P/qcXyKNagbSARHGMTZznfdVw4kmSOZv3SLBZFjA+CxaNVD
         mllzOMA0eFVoneLf1NA8tKcJo6XnxgHBfk5h9LbCgNOcJr5TSoWW6Oedye62NaDXnV
         XtWYBp0r4NLRSiUNIZRHMwmzNzPgglRVukyLtWuU4/0+TXkHDRCY2uLvkrPeUdiA2J
         dDrYjEqhVZTduDzaaYDrSpZ+zoKGHM865XYfI3nMQUtFgjIjWRbV2QMaAIf2LHyHSc
         /i55o3N91xPDug+yCmC+HOeJZS+TlF8bwb0puIHDSfF0laFc3zq4dIWiY+WOoETcX7
         +xkFKTqF6ae+g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B673C15C430A; Fri, 17 Jun 2022 22:12:13 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Baokun Li <libaokun1@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, lczerner@redhat.com,
        yukuai3@huawei.com, yebin10@huawei.com,
        linux-kernel@vger.kernel.org, adilger.kernel@dilger.ca,
        yi.zhang@huawei.com, jack@suse.cz, ritesh.list@gmail.com
Subject: Re: [PATCH v3 0/3] ext4: fix two bugs in ext4_mb_normalize_request
Date:   Fri, 17 Jun 2022 22:12:06 -0400
Message-Id: <165551818832.612215.8334554398327312185.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220528110017.354175-1-libaokun1@huawei.com>
References: <20220528110017.354175-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, 28 May 2022 19:00:14 +0800, Baokun Li wrote:
> The logical block map reached before the problem stack was 1011.
> The estimated location of the size logical block of the inde plus
> the required allocation length 7, the size is 1018.
> 
> But the i_size of inode is 1299, so the size is 1299,
> the aligned size is 2048, and the end is 2048.
> Because of the restriction of ar -> pleft, start==648.
> 
> [...]

I've applied the first two patches, thanks!

[1/3] ext4: fix bug_on ext4_mb_use_inode_pa
      commit: 0fb337007c8cbdaef5bed798c30a82723f97f4cb
[2/3] ext4: correct the judgment of BUG in ext4_mb_normalize_request
      commit: d1389cc90702fea565a6efd4d1d0c5c8fe1cc317

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
