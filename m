Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53814731C16
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jun 2023 17:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344193AbjFOPA7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Jun 2023 11:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344392AbjFOPAo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Jun 2023 11:00:44 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C763F2944
        for <linux-ext4@vger.kernel.org>; Thu, 15 Jun 2023 08:00:34 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-128-67.bstnma.fios.verizon.net [173.48.128.67])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35FExxWP026895
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 11:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686841202; bh=bqsSWsv2FgVt7A/NVFwu5x20dKwoSJZHizGcwbcBX6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=iqDPo8W9mMYI61Hl2BS738tm5WDV7yRC3GfuDBSkFzHKFYbS5YGGSW+6uszkEC8EF
         uzv78BkkyCujPCQxJTmZ/N8rz+pJuiFOuOgW9mpIV4qcx7+xAbFHhWE8TIoRo8uQze
         MWAD7ZN9mwCYtNZoZ17YNB528hMT3vFhP3JcpEliNNoSK9BhmFVr2dy3vs6vaNrhnK
         pNx5+EcVp2pjta7NimPyQs9Wew4n8bam7y6wnMXE2xDLeic3rzsLbQ4ReCKRmSpao1
         j+ChPXV5T13bmz30pke56NIgT5TUA97N4y4l6ydlE++GeLjcuFNChi/72qzKNRcbsp
         cRg5GepOTow3Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D365515C02DF; Thu, 15 Jun 2023 10:59:59 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Baokun Li <libaokun1@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 0/2] ext4: fix quotas leak in __ext4_fill_super()
Date:   Thu, 15 Jun 2023 10:59:55 -0400
Message-Id: <168683994077.282246.1824040252108506473.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230327141630.156875-1-libaokun1@huawei.com>
References: <20230327141630.156875-1-libaokun1@huawei.com>
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


On Mon, 27 Mar 2023 22:16:28 +0800, Baokun Li wrote:
> V1->V2:
> 	Add judgment for CONFIG_QUOTA to avoid warning
> 	"label 'failed_mount9' defined but not used".
> 	(Reported-by: kernel test robot <lkp@intel.com>)
> V2->V3:
> 	By adding __maybe_unused to silence possible compilation
> 	complain in patch one, instead of adding the judgment.
> 	(Suggested by Jan Kara).
> 
> [...]

Applied, thanks!

[1/2] ext4: turning quotas off if mount failed after enable quotas
      commit: e39a0c8d9cc298c5a4afdeb416441091ae3f1fcb
[2/2] ext4: refactoring to use the unified helper ext4_quotas_off()
      commit: 63ec000b35a3c6cbb42b2e545c7c18f3d36159d6

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
