Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E19657E2AF
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jul 2022 15:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235242AbiGVN6m (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Jul 2022 09:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiGVN6i (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Jul 2022 09:58:38 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4D58E6D7
        for <linux-ext4@vger.kernel.org>; Fri, 22 Jul 2022 06:58:37 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26MDwUJE016785
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 09:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1658498311; bh=FZ1hEHcgE8PeiD3hrxhgsOC5zYrrOVFRwVEEbrC4Xf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VJ3GOg9+vBYVHZDMIlMxU+7ImCJzupIuf2f9HY9Q3q8IGHiKcZZDV4TJKiyEVrBsm
         31mxGbVhInFvS+16i8+bNZiNwEhVMffKLARgf0a1JrxwdDk4gO2Wz+kKagfPSJZWxj
         UkKJe5YGgEEn6ZGpjuz9sWwdiaWan7n+41G3NEuKA8nIbXloCMHb3GUqnbYqpNbsEA
         4upZ9OqltBzB8pb4k39LEX+hkF8iiFsetmmId2fMXM0w361DfrZDQnVoe+Ole2RBkq
         AT/sKAzxjcEj3WRmk4ZlSgIiOIRQ3QJ971aPP3df+fWPLp6Jkjx4LOfl7QWyuKy6gs
         4NOlv4Z1YjSfw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 79EB415C3F09; Fri, 22 Jul 2022 09:58:27 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, okiselev@amazon.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH -V2 2/2] ext4: avoid resizing to a partial cluster size
Date:   Fri, 22 Jul 2022 09:58:22 -0400
Message-Id: <165849767596.303416.9593678472601195632.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <0E92A0AB-4F16-4F1A-94B7-702CC6504FDE@amazon.com>
References: <0E92A0AB-4F16-4F1A-94B7-702CC6504FDE@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 20 Jul 2022 04:27:48 +0000, Kiselev, Oleg wrote:
> This patch avoids an attempt to resize the filesystem to an
> unaligned cluster boundary.  An online resize to a size that is not
> integral to cluster size results in the last iteration attempting to
> grow the fs by a negative amount, which trips a BUG_ON and leaves the fs
> with a corrupted in-memory superblock.
> 
> 
> [...]

Applied, thanks!

[2/2] ext4: avoid resizing to a partial cluster size
      commit: 7c943cf3692f71226f462b80a1f367c788f84d1c

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
