Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C46542F11
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jun 2022 13:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238125AbiFHLX7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Jun 2022 07:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237507AbiFHLX5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Jun 2022 07:23:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECFC12E83B
        for <linux-ext4@vger.kernel.org>; Wed,  8 Jun 2022 04:23:56 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7A9ED21A42;
        Wed,  8 Jun 2022 11:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654687435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=v9vxlr+EK8ZU/ILUdMbZrlQBZKn8ek/40cMZC9bBwdE=;
        b=AnQCRTNx1qx4lFSkjkle9PrQENMpYNG+TfFW1zuGxzmJo09/ed4Nksdf+7SxtbYkp4bIYN
        FGupo5Z+hl/yeew2fMh1t8jCgNUQglN6TH3La20oezUqy2gvDhSF4gMyLcnZaJ7Jb4y4CF
        JdT+3UFAC+FKELf5E8x421IFctQw2yk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654687435;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=v9vxlr+EK8ZU/ILUdMbZrlQBZKn8ek/40cMZC9bBwdE=;
        b=upQAoiKrr5v5VRFV1kmo4LrES/D7BlA6T5f76iiN9qw7OoyT/nU7+ADvqcMbsJ8PBUK+TA
        mAQ8NZRMPrjqF9Aw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 684EE2C142;
        Wed,  8 Jun 2022 11:23:55 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 237CDA06E2; Wed,  8 Jun 2022 13:23:55 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/4] ext4: Debug message and export cleanups
Date:   Wed,  8 Jun 2022 13:23:46 +0200
Message-Id: <20220608112041.29097-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=141; h=from:subject:message-id; bh=xEAM4DQgOv/G8nnxMnwOgakyaL7EWBGm3Zs6Re13uiU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBioIa7+y1tV6Cak2lXLuSJYmQL+Tz8bn0++FaLmjfv 5w3bMu6JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYqCGuwAKCRCcnaoHP2RA2TwjB/ 9aPEaqP/smE/rtK+z0IcYSgcjXsikgjUfte9kxC7HhqJcKbc8gpiuhcS4uoP8N28PIWniL1Vi6peA9 KeLgIV8Pv5qw6LtXRMRGVnCRJxAFTM9Hu/l+AeESMs+ymq64TnD/b74GNmsv+w5HQpC3+1WS2llfl9 ktHPaENBMdT7Aqi6me6mPEsktn/ZsXEv5lAtZIZvE2D2lBIxYiE6Q5vNKGn+FPkQ9z6zZjQjT5TAZG 5QcEU5hEfMn6ropXdpCVhcTcbnatUIcQhiVr1qs4Dj7PGkGVwDGyh69GapE6Kr5Z1Z8W0kWLtkqUz+ K0Ggje/EZXdcleosLBdovLybab/Brn
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

this series cleans up couple of things around debug messages in ext4/jbd2
and removes some unnecessary exports.

								Honza
