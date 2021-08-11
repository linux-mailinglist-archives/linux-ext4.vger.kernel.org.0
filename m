Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8373E8E5E
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Aug 2021 12:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237016AbhHKKTv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Aug 2021 06:19:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47596 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236877AbhHKKTu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Aug 2021 06:19:50 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0CB56221CB;
        Wed, 11 Aug 2021 10:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628677166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=W6fjv18x3XQto0cyYhTfr5rK8+/G6J1kcMvceN0Dros=;
        b=Gl/IfxDMgaO6c77qwtkmQnPoF9R4PFlv4ckWvzlI7WLUqBJirHo03KHJFYKX+VqO2+oUrt
        ylI9Fepvn3eogXsyAzivvkW+ssu2Kjb3Ipp1PnhF/UufIJY01MRu4BoOe6o2JNpbC7RJaL
        xIlCMkSVdf9dgNbS/4P9Fizn/QYysKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628677166;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=W6fjv18x3XQto0cyYhTfr5rK8+/G6J1kcMvceN0Dros=;
        b=TazIb9qi/HH3oFtODdKAtIzWp8fqoVHkCZjMqAYlX8EOnh9AnQ88lUl6Hx1+A9CR3zjI5D
        nF5wczUXCU2LNwBQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 02AD1A3BE6;
        Wed, 11 Aug 2021 10:19:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CD1BA1E6204; Wed, 11 Aug 2021 12:19:25 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/5 v5] ext4: Speedup orphan file handling
Date:   Wed, 11 Aug 2021 12:19:10 +0200
Message-Id: <20210811101006.2033-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1975; h=from:subject:message-id; bh=N2fonlPC2k6rxpYPA2hxfCZVgma16LVebCGXiGx8nN8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhE6QX5jQipr833iqNzikViZgewJyoyjggQeNpnpeZ ZLSrEOuJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYROkFwAKCRCcnaoHP2RA2U0UCA DZydcWF+HQeI6zRfbfXdUDjxcZtklkSSxw3Wtm+xhC8oaliATqB+CG/6aQut2sJpYNnABtc1vu2XUs J4C+dCN8/7Yp9eaghb/M2IPEWiWJlMVTChe/+3owkawIc4RHHRbI+jUSN5zIPLsDjegAeQ3pccPHXu r9hE1lpXrW4dR5YMA2mNwPj5KYxopPJjZ4FLprGri+cAgHlGaUjfI7mCpKsGoomRTXL29XWCdB6SPa 9yxrloh+CX1tPuuyOIsUdtC06KwiJRHtl7GJ0+64G5Nw+jF5tHziizEebR9Em4MaWaRGlBF0gHItp3 Iz88sjQ0pcsWu8L4R2eeezCnwuu8kU
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

  Hello,

Here is a fourth version of my series to speed up orphan inode handling in
ext4.

Orphan inode handling in ext4 is a bottleneck for workloads which heavily
excercise truncate / unlink of small files as they contend on global
s_orphan_mutex (when you have fast enough storage). This patch set implements
new way of handling orphan inodes - instead of using a linked list, we store
inode numbers of orphaned inodes in a file which is possible to implement in a
more scalable manner than linked list manipulations. See description of patch
3/5 for more details.

The patch set achieves significant gains both for a micro benchmark stressing
orphan inode handling (truncating file byte-by-byte, several threads in
parallel) and for reaim creat_clo workload. I'm happy for any review, thoughts,
ideas about the patches. I have also implemented full support in e2fsprogs
which I'll send separately.

								Honza

[1] https://lore.kernel.org/lkml/20210227120804.GB22871@xsang-OptiPlex-9020/

Changes since v4:
* Rebased on top of v5.14-rc5
* Updated commit message of patch 1/5
* Added Reviewed-by tags from Ted

Changes since v3:
* Added documentation about on-disk format changes
* Add physical block number into orphan block checksum
* Improve some sanity checks, handling of corrupted orphan file
* Improved some changelogs

Changes since v2:
* Updated some comments
* Rebased onto 5.13-rc5
* Change orphan file inode from a fixed inode number to inode number stored
  in the superblock

Changes since v1:
* orphan blocks have now magic numbers
* split out orphan handling to a separate source file
* some smaller updates according to review

Previous versions:
Link: https://lore.kernel.org/linux-ext4/20210712154009.9290-1-jack@suse.cz/ #v4
Link: https://lore.kernel.org/linux-ext4/20210616105655.5129-1-jack@suse.cz/ #v3
Link: https://lore.kernel.org/linux-ext4/1432293717-24010-1-git-send-email-jack@suse.cz/ #v2
