Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC92852B6A8
	for <lists+linux-ext4@lfdr.de>; Wed, 18 May 2022 12:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbiERJdq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 May 2022 05:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234342AbiERJdo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 May 2022 05:33:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37705AFB01
        for <linux-ext4@vger.kernel.org>; Wed, 18 May 2022 02:33:34 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CFC511F9B2;
        Wed, 18 May 2022 09:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652866412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=tmt2/NW3Zkl/wtNMIvZl4eSrxZruJ11KaRJFrhL9csE=;
        b=fPb0EuGHkMDvpQXeu8o0hCCQZiZYYRpySgNPF+/iTShhgmFWuIx5VKnzdomxkBrEfpMcoh
        /U0/ar239MzWiBOorrcIoJg5LrOkAcsNavTw/zC73tDKjSSt7RQCbbUNCdNUZPBY439DLZ
        Kd/MrZ8DtQGwzvFkRPlZlN9cUqZORhY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652866412;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=tmt2/NW3Zkl/wtNMIvZl4eSrxZruJ11KaRJFrhL9csE=;
        b=keMCZ3Tp3Tt6hEFpndqgb9Tbi+Zg6HV9O5BmHa/vXvGA2fbmFsp18RzCVdgZ6YboorTyWh
        xpi+ifz/XrQY8VBQ==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C43122C162;
        Wed, 18 May 2022 09:33:32 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 76087A062F; Wed, 18 May 2022 11:33:32 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2 v2] ext4: Fix crash when adding entry to corrupted directory
Date:   Wed, 18 May 2022 11:33:27 +0200
Message-Id: <20220518093143.20955-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=681; h=from:subject:message-id; bh=aQ6bcZIVUFcha8JNYMboXFbaiZi5girJ200Ur67xkRQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBihL1fCUQxg5tCWlc6pEXFWqMZeHtHvqA9e71CPOJo s+VwKveJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYoS9XwAKCRCcnaoHP2RA2SvhCA DvkIbdFOEE9eeUwNx3DKjNArxK+8CU5OwIkAxNXgRxeZw22xqOeQJm+7kH3eXMhOkZLKI2heKmAi4X QItxmNeodmbCgYd5fpzQzKx7QUO40EC1uE032vcHeljq+zEF6vlzJya04p75MsSo4sk8/HPpj3v3DK zA2UzwAmpNDYAp4BJ1aDCb00XjgvxXkTTdQCdEED6qOTBZT2S6NNIgoB+0UswMSzer8OpuBTiF+agl t863O1pZPcS5TFtnN2IH1361yohcQcBOnugM4PILV3A+Mo9TI4Ewf8+PRBsy1C+dSG8PpnCYHjUgRo 7JFPqZ+yncu9MFEuIyxz1aW7mAWrfO
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

two patches in this series try to fix a crash when adding directory entry to a
directory with corrupted h-tree. Since I don't have the filesystem image
causing the crash, I'm not sure what was the cause but the stacktrace suggests
we have corrupted one h-tree node while modifying another one so likely
there was a cycle created in the h-tree. This series checks for it and bails
out early.

Changes since v1:
* Fixed compilation error in the first patch (which got fixed in the second
  patch)
* Fixed stack corruption issue with largedir feature

								Honza

Previous versions:
Link: http://lore.kernel.org/r/20220428180355.15209-1-jack@suse.cz # v1
