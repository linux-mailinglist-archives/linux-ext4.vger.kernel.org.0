Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354E77BBE72
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Oct 2023 20:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbjJFSHV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Oct 2023 14:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjJFSHR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Oct 2023 14:07:17 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F7C10C
        for <linux-ext4@vger.kernel.org>; Fri,  6 Oct 2023 11:06:53 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-111-143.bstnma.fios.verizon.net [173.48.111.143])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 396I6Z66008120
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Oct 2023 14:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1696615597; bh=cVLodiHXXqwas2hf6O+mysVZWt3Td9WU1oZufvWjZa8=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=hhUoeXZu6ItMWHLVpFkfuIq8298wnuBLrySa/seAoVpgXSmInEOciYXP8A0fOLiQ4
         X9fJoBgecOfvd+KFAmeoMOW+7Zronj8a2yCSAaxKyAvQoSv+PB5zVdKl+OnsDCTK2T
         0qfiYQuv3t10iu02GcEGwVC8FMkGZc2Nyo4tGrqD/Efzcq9wdiYu1IienEQSYwNSU/
         HehsIsE2jlx/z7Y3wfI6ykXiagLXKJOyWc3rhP3TbfhvQFyMZoPoMkyB2RDSedE/J8
         GOGXJVe8FBQ/156CVCVstIhnAtg0fYu+4fSy5br6hZ2VueotSi97yEFmWT9OteyR2S
         vAqxIwHl/4Hiw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2A1FB15C026A; Fri,  6 Oct 2023 14:06:33 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     ritesh.list@gmail.com, adilger.kernel@dilger.ca,
        Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, ojaswin@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/12] cleanups and unit test for mballoc
Date:   Fri,  6 Oct 2023 14:06:25 -0400
Message-Id: <169661554693.173366.10425760785388964424.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230928160407.142069-1-shikemeng@huaweicloud.com>
References: <20230928160407.142069-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On Fri, 29 Sep 2023 00:03:55 +0800, Kemeng Shi wrote:
> v7->v8:
> 1. Convert all ext4_mb_mark_bb to use bool in patch 1.
> 2. Improve commit msg as Ritesh suggested.
> 3. Collect RBs from Ritesh. A lot thanks to Ritesh!
> 
> v6->v7:
> 1. Remove struct ext4_mark_context and call ext4_mb_mark_context with all
> needed arguments directly.
> 2. Add new patch to make state in ext4_mb_mark_bb bool and make state in
> new-added function ext4_mb_mark_context bool.
> 3. Fix typos in git messages.
> 4. Keep on-disk bitmap marking code tight in patch separating on-disk
> bitmap and buddy bitmap freeing.
> 5. Test 64k blocksize instead of 256k blocksize.
> 6. Remove RVB from Ojaswin in changed patches and collect updated RVB from
> Ritesh.
> 7. As there is no much functional change to initial version, "kvm-xfstest
> smoke" test and kunit test are ran and result is good.
> 8. Plan to add ext4_inode_block_valid in ext4_mb_mark_context in new
> series!
> 
> [...]

Applied, thanks!

[01/12] ext4: make state in ext4_mb_mark_bb to be bool
        commit: d2f7cf40ea89b486fb7a25f5ab9a5d3ce26fb4bb
[02/12] ext4: factor out codes to update block bitmap and group descriptor on disk from ext4_mb_mark_bb
        commit: f9e2d95a45321857bd0397aa07ae30cc20f0988f
[03/12] ext4: call ext4_mb_mark_context in ext4_free_blocks_simple
        commit: 26d0f87b9fff37f9d4a04aa49f40b0d24502d2b1
[04/12] ext4: extend ext4_mb_mark_context to support allocation under journal
        commit: c431d3867e0a8258d1948408eb8297cdd2400e67
[05/12] ext4: call ext4_mb_mark_context in ext4_mb_mark_diskspace_used
        commit: 2f94711b098bc55285ac74aba2f2b83fd72b555f
[06/12] ext4: Separate block bitmap and buddy bitmap freeing in ext4_mb_clear_bb()
        commit: 33e728c67db6b7e72fc8d09f7a38f72302b8a98d
[07/12] ext4: call ext4_mb_mark_context in ext4_mb_clear_bb
        commit: 38b8f70cd28c6ad21192d82f271b9e32bdcb8600
[08/12] ext4: Separate block bitmap and buddy bitmap freeing in ext4_group_add_blocks()
        commit: 03c7fc39a677cdeae076d8b9ecc10920dd13f6a8
[09/12] ext4: call ext4_mb_mark_context in ext4_group_add_blocks()
        commit: 5c657db46d9ebc63e57be1408f1986c9b23368e1
[10/12] ext4: add some kunit stub for mballoc kunit test
        commit: bdefd689b7ff0eadc3b29dc6c66556617bd1ed42
[11/12] ext4: add first unit test for ext4_mb_new_blocks_simple in mballoc
        commit: 7c9fa399a369546c0e0375ea4b354d642a8fe501
[12/12] ext4: run mballoc test with different layouts setting
        commit: 28b95ee868072f1cd029245bf96cf02844322f37

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
