Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3D6513B99
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Apr 2022 20:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351087AbiD1SfG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Apr 2022 14:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351070AbiD1SfC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Apr 2022 14:35:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D51CBC849
        for <linux-ext4@vger.kernel.org>; Thu, 28 Apr 2022 11:31:46 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id ED3DF21870;
        Thu, 28 Apr 2022 18:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651170704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=B+EW8l3F8irlpyDH8ASBGnaXBLEGcgPgm/I4WqI1ip0=;
        b=YkOFgli1EzeTPzsE1K3Qe+d20EIS6Iv2maXlMkvcycYEn6VaqPVoFYGPAjh8fSfn+IW0Lj
        +oa+fqW9D16E/DngX8UlNA7siYz4uWBE7RL6RD75Pnq9nHUBAK81QHea7SIc6YXq9s7ili
        gRSMa1g3qXphbQdazmun1+hNefpZ9I0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651170704;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=B+EW8l3F8irlpyDH8ASBGnaXBLEGcgPgm/I4WqI1ip0=;
        b=LjObfy6ia6besCd0YvtS8q3rmVfCUzHyFZoCD0/9I8l+QDuUrpkf/9P2vtvxuyxDnbe/X1
        8EYuEAoY3Kb6O1BA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C0AC12C142;
        Thu, 28 Apr 2022 18:31:44 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B6A1EA061A; Thu, 28 Apr 2022 20:31:43 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2] ext4: Fix crash when adding entry to corrupted directory
Date:   Thu, 28 Apr 2022 20:31:36 +0200
Message-Id: <20220428180355.15209-1-jack@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=424; h=from:subject:message-id; bh=wR5TsJzAR0r7sQ3bXyWPgttoDGZuJABgxOSnhEVKc6M=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBiat1+nRc1d52MP49aP2DEe7gatxHI3UTTsUdQeTxz dkOUn1CJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYmrdfgAKCRCcnaoHP2RA2egPB/ 4xlwppqqO0Koo8KjqnulPRMjgDwlSvNAcqUct6s3Eb0LrJKIA3+IMX8b0IznlEISlg4uXqEsYRHVi1 wW6gb4WRYzk/flXksAlX8naFO6XuyaqdtaU4cw+nYexiK+MbKGMyT0rKve91GRBjClXtQjuXTwW986 WkgOzWAsGyY/swbYEuq8z+zkjXgysMsSUoHgIl01v8bWT7985HMrF4R438M+dYmITWMk3+fVop4tIf HUgNBSVR0wpaSpc9TzXDLB5wrXq2+m3L5zcrj2woNkCmUo3SBKjXKNplbt7A9Ij85Wd2VLOU86gGcF hTM7dKjRIqzsPGBmC5E8F1uohOwOvi
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

								Honza
