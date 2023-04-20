Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659846E996E
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Apr 2023 18:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjDTQWZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Apr 2023 12:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbjDTQWW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Apr 2023 12:22:22 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D8C4EEB
        for <linux-ext4@vger.kernel.org>; Thu, 20 Apr 2023 09:22:13 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33KGLn4A022422
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 12:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682007713; bh=Pgoib2xJLamlh14Ws3Aj+acQ/+ZcnQAq6JGT3R0x8hE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=iV5w4qFe2rHE2zHGxyJL3EyEqolylwCFLa9jV9nG9k6/Q3O7AOYmQOUec87r0uB58
         emoSOE/H29x72MCp4y3g6zLDtWMIEzAQ2Wc3BB1rslVE/9Un1rgpe8oh4pVL8w7ch+
         zzjLEgrNXmrAFKW6FEY3qVAqwzkHWnqYnZhtF6Deuyo78WE4xm1OwGcVN5cvsElMa7
         pxTdrX5z9e2MehHsLGsih5e/f74roACGbKohzbzd3XkaZxERSm/nrwfFJQxySJA4KQ
         WGFk6/3jzEtLXrTyMDgQH2tc4A+t9zFBd9d8gCY8k0swOO2yRg4VPkqv1dhRQ9k/RB
         W6wSMYQv9LR/w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E9B4E15C543F; Thu, 20 Apr 2023 09:47:12 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        lczerner@redhat.com, linux-ext4@vger.kernel.org,
        Jason Yan <yanaijie@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 0/8] some refactor of __ext4_fill_super(), part 2.
Date:   Thu, 20 Apr 2023 09:47:11 -0400
Message-Id: <168199842264.1078192.15929592065751634681.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230323140517.1070239-1-yanaijie@huawei.com>
References: <20230323140517.1070239-1-yanaijie@huawei.com>
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


On Thu, 23 Mar 2023 22:05:09 +0800, Jason Yan wrote:
> This is a continuous effort to make __ext4_fill_super() shorter and more
> readable. The previous work is here[1]. I'm using my spare time to do this
> work so it's a bit late after the previous series.
> 
> [1] http://patchwork.ozlabs.org/project/linux-ext4/cover/20220916141527.1012715-1-yanaijie@huawei.com/
> 
> Jason Yan (8):
>   ext4: factor out ext4_hash_info_init()
>   ext4: factor out ext4_percpu_param_init() and
>     ext4_percpu_param_destroy()
>   ext4: use ext4_group_desc_free() in ext4_put_super() to save some
>     duplicated code
>   ext4: factor out ext4_flex_groups_free()
>   ext4: rename two functions with 'check'
>   ext4: move s_reserved_gdt_blocks and addressable checking into
>     ext4_check_geometry()
>   ext4: factor out ext4_block_group_meta_init()
>   ext4: move dax and encrypt checking into
>     ext4_check_feature_compatibility()
> 
> [...]

Applied, thanks!

[1/8] ext4: factor out ext4_hash_info_init()
      commit: db9345d9e6f075e1ec26afadf744078ead935fec
[2/8] ext4: factor out ext4_percpu_param_init() and ext4_percpu_param_destroy()
      commit: 1f79467c8a6be64940a699de1bd43338a6dd9fdd
[3/8] ext4: use ext4_group_desc_free() in ext4_put_super() to save some duplicated code
      commit: 6ef684988816fdfa29ceff260c97d725a489a942
[4/8] ext4: factor out ext4_flex_groups_free()
      commit: dcbf87589d90e3bd5a5a4cf832517f22f3c55efb
[5/8] ext4: rename two functions with 'check'
      commit: 68e624398f7df3fd91d4a4cd148e722a18d76054
[6/8] ext4: move s_reserved_gdt_blocks and addressable checking into ext4_check_geometry()
      commit: 269e9226c29fbfe7f66a324d6d32d4a53bcffbbe
[7/8] ext4: factor out ext4_block_group_meta_init()
      commit: 107d2be90116a1731d2d81296100c0a4c454a89f
[8/8] ext4: move dax and encrypt checking into ext4_check_feature_compatibility()
      commit: 54902099b1d8b62bea7cfd949aa3acd9eae1c3db

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
