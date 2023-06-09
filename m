Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4180D728E59
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Jun 2023 05:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237524AbjFIDNR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Jun 2023 23:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjFIDNQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Jun 2023 23:13:16 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F5230D1
        for <linux-ext4@vger.kernel.org>; Thu,  8 Jun 2023 20:13:14 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-39.bstnma.fios.verizon.net [173.48.82.39])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3593D9eW023654
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Jun 2023 23:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686280390; bh=kKz3TNI01xeiIHWRqVFV2zRQes4mge4CNRGnTAb7Z+M=;
        h=Date:From:To:Cc:Subject;
        b=oqJO11JezYfiVCTXQAt1tdldwLWcIZ5kvOYIrUA6vLoGY6PR3ptinzmrnQvzRUl2b
         8kdKJqOcgOg3QXxj5EohmbFn4nx32V5xcN0RffjC2lg9Z5E/N8TGeGn3pV5sEfs5xm
         y8Ho0cwCHyY1m0GR+DIhd2Dodc0quWtUCuGYX1ZtC6XIHPbCTsbsRdHcnkEqrUhsQU
         IvZZ+4Mv11CV+m/+9T7gfrca05GR7LqNNpYgFvXn9qtiLO0zQ4m+l+jgj3OZT+4aoi
         nTVco4xh/PdO3Ku3YkR7m1Yk9TYTKm4TXqbQroSiRHbsHSJAE/o9E0xd8G1pSxXcgG
         4z/X9TAraBwrA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0824C15C00B0; Thu,  8 Jun 2023 23:13:09 -0400 (EDT)
Date:   Thu, 8 Jun 2023 23:13:09 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ext4 regression fix for 6.4-rc6
Message-ID: <20230609031309.GA1458078@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit 9561de3a55bed6bdd44a12820ba81ec416e705a7:

  Linux 6.4-rc5 (2023-06-04 14:04:27 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

for you to fetch changes up to dea9d8f7643fab07bf89a1155f1f94f37d096a5e:

  ext4: only check dquot_initialize_needed() when debugging (2023-06-08 10:06:40 -0400)

----------------------------------------------------------------
Fix an ext4 regression which breaks remounting r/w file systems that
have the quota feature enabled.

----------------------------------------------------------------
Theodore Ts'o (2):
      Revert "ext4: don't clear SB_RDONLY when remounting r/w until quota is re-enabled"
      ext4: only check dquot_initialize_needed() when debugging

 fs/ext4/super.c | 6 +-----
 fs/ext4/xattr.c | 6 ++++--
 2 files changed, 5 insertions(+), 7 deletions(-)
