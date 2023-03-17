Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA486BDE4C
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Mar 2023 02:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCQBxA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Mar 2023 21:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCQBxA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Mar 2023 21:53:00 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B8A61537
        for <linux-ext4@vger.kernel.org>; Thu, 16 Mar 2023 18:52:58 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32H1qlVW031899
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 21:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1679017968; bh=xmbt+j2sy8kmTUR/4qwCUQJGduULOjBmGgjjYjepqFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=d053WV9xnd6KuWHXGKvsI4xKXiht8i71WWCsX/p+PghD48J2hfvvRjemCYI2e04zG
         tcfKzZQ0nYm1rB5BdFLiK8uR6iuUdqg3BsPl/xhX2OwkhVLghBrBJSqk+LQLAhjn5K
         9p/0qX+fvvryozbvYOk+kMlvRp3gDAoKEiZOp0i8QD7cVhlLAUc0y2onkiyoS6yeA9
         oBofEN4B2BP156fPHObySqF/2nt50uQIvtNYooMPHS7lf4Pr0fXgNkUGp5pRZd+vob
         uabGz2TGmjaqok1smxUwcbFh2Tp+8ocy5MNNwTj9XJAV84/vTqyH1XL/geqbmYujTX
         YgqodA+0ujdhw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 26B2115C45BA; Thu, 16 Mar 2023 21:52:47 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, adilger.kernel@dilger.ca
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] A few patches to improve ext4 balloc
Date:   Thu, 16 Mar 2023 21:52:44 -0400
Message-Id: <167901794965.3178390.7192495560091164685.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230221115919.1918161-1-shikemeng@huaweicloud.com>
References: <20230221115919.1918161-1-shikemeng@huaweicloud.com>
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

On Tue, 21 Feb 2023 19:59:12 +0800, Kemeng Shi wrote:
> ext4_read_block_bitmap_nowait to avoid potential data
> inconsistent, correct validation check of inode table in
> ext4_valid_block_bitmap and other random cleanup patches.
> More details can be found in respective log.
> Thanks!
> 
> Kemeng Shi (7):
>   ext4: properly handle error of ext4_init_block_bitmap in
>     ext4_read_block_bitmap_nowait
>   ext4: correct validation check of inode table in
>     ext4_valid_block_bitmap
>   ext4: call ext4_bg_num_gdb_[no]meta directly in
>     ext4_num_base_meta_clusters
>   ext4: remove unnecessary check in ext4_bg_num_gdb_nometa
>   ext4: remove stale comment in ext4_init_block_bitmap
>   ext4: stop trying to verify just initialized bitmap in
>     ext4_read_block_bitmap_nowait
>   ext4: improve inode table blocks counting in
>     ext4_num_overhead_clusters
> 
> [...]

Applied, thanks!

[1/7] ext4: properly handle error of ext4_init_block_bitmap in ext4_read_block_bitmap_nowait
      commit: 68070432da0de5e346f5f75a76f76858000c8e53
[2/7] ext4: correct validation check of inode table in ext4_valid_block_bitmap
      commit: 1d4ef2264e0f18275d8176fa3083a7988117de40
[3/7] ext4: call ext4_bg_num_gdb_[no]meta directly in ext4_num_base_meta_clusters
      commit: 8bd501d2ef66bb06765aecfd3a69a5ac3213e28f
[4/7] ext4: remove unnecessary check in ext4_bg_num_gdb_nometa
      commit: 6b8948ef40e97de05fa6329eb985c9cc1168aefa
[5/7] ext4: remove stale comment in ext4_init_block_bitmap
      commit: 35690178606526d33a8ae254660a8a2239a08d6d
[6/7] ext4: stop trying to verify just initialized bitmap in ext4_read_block_bitmap_nowait
      commit: 23a7838694dc48315b38d0cf111afaaedfc5081f
[7/7] ext4: improve inode table blocks counting in ext4_num_overhead_clusters
      commit: e3c70113e2cbeb3dadb3768964920337eff290f6

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
