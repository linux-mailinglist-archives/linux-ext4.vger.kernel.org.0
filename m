Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1356BB967
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Mar 2023 17:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbjCOQRT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Mar 2023 12:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjCOQQ7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Mar 2023 12:16:59 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF0E46A3
        for <linux-ext4@vger.kernel.org>; Wed, 15 Mar 2023 09:16:22 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32FGGFJD006774
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 12:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678896977; bh=cRcmEHcLnRAsphIF7ZROmgHmQGHdVjndCn0IbmwK60A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GB11b/RwgyFACCLZCVDET1M+u3A9KpJggJOy9WGfSJbBfnvT97ePZfDdlpBA7oDYB
         Eb8XDJDSgdzV9TxYpDQZNN9kn//yVAT5B5l9dTvIiqY5fFRX7HG9kyO/YP5a3iNuHW
         pGr+cM3RBLts+59r8ruELhJu3Mb9iGg4LGslf8wsZ/4ipSU4nQ3Vf7XqG6ydwUXP65
         4bDWwlwXwqGJTOOg3o1yjxQvobLuv9JhZDl4qnpPVid+WFxY/jbu3xDIu/p4oK5HOZ
         Q2l5bhG/O4dBywt1T2hflMn9CEDgILhodI2TziZn9k9JFIBoESiSzueG8qB5wW993+
         170VeAvbYQbhQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 05D7C15C5830; Wed, 15 Mar 2023 12:16:15 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix warnings when freezing filesystem with journaled data
Date:   Wed, 15 Mar 2023 12:16:11 -0400
Message-Id: <167889696171.3024151.1866086875866580261.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230308142528.12384-1-jack@suse.cz>
References: <20230308142528.12384-1-jack@suse.cz>
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

On Wed, 8 Mar 2023 15:25:28 +0100, Jan Kara wrote:
> Test generic/390 in data=journal mode often triggers a warning that
> ext4_do_writepages() tries to start a transaction on frozen filesystem.
> This happens because although all dirty data is properly written, jbd2
> checkpointing code writes data through submit_bh() and as a result only
> buffer dirty bits are cleared but page dirty bits stay set. Later when
> the filesystem is frozen, writeback code comes, tries to write
> supposedly dirty pages and the warning triggers. Fix the problem by
> calling sync_filesystem() once more after flushing the whole journal to
> clear stray page dirty bits.
> 
> [...]

Applied, thanks!

[1/1] ext4: Fix warnings when freezing filesystem with journaled data
      commit: 18b7f4107219ef12898b2ee77b8fb6de8887d1b7

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
