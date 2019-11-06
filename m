Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A453F139A
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Nov 2019 11:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfKFKPR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Nov 2019 05:15:17 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59259 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725856AbfKFKPR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Nov 2019 05:15:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573035316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=YP9EVR09MZiKrv4YS5q3sHAfg7F5RhYfSOQz4XcaRn8=;
        b=Xsz4LBaL4imyvCg4/bpiZjkng1bbSPNUyGiFe8hZRRANMr7qSO5l8Pe92wLwvR3V9bICX8
        yFqsqrtxYUhru6DbTiP7C+Rm/XG1me5rPEEMam0QystX2DMV7KO6AQfW0UJ+RxFKcH80S2
        0XKNEYRjMcQeV/Yi1fokrBxgzwzCrsA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-1B2Z87_4PECyQ1xq5oCFmg-1; Wed, 06 Nov 2019 05:15:14 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C828C1005500;
        Wed,  6 Nov 2019 10:15:13 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.205.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 665EC26DC5;
        Wed,  6 Nov 2019 10:15:10 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: ext4: new mount API conversion
Date:   Wed,  6 Nov 2019 11:14:40 +0100
Message-Id: <20191106101457.11237-1-lczerner@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 1B2Z87_4PECyQ1xq5oCFmg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following patch converts the ext4 to use the new mount API
(Documentation/filesystems/mount_api.txt).

The series can be applied on top of the current mainline tree and the work
is based on the patches from David Howells (thank you David). It was built
and tested with xfstests and custom script to check all ext4 mount options
and some valid/invalid combinations.

This series also requires a small fix to the parsing infrastructure from
David Howells which has not been adopted yet - "vfs: Handle
fs_param_neg_with_empty"

I've tried to avoid big unrelated changes to the original ext4_fill_super()
and ext4_remount, though it could definitelly use some cleanup. This can
be done after the conversion with a separate patch set.

-Lukas

---

David Howells (1):
=09[PATCH 01/17] vfs: Handle fs_param_neg_with_empty

Lukas Czerner (16):
=09[PATCH 02/17] ext4: Add fs parameter description
=09[PATCH 03/17] ext4: Refactor parse_options
=09[PATCH 04/17] ext4: handle_mount_opt use fs_parameter
=09[PATCH 05/17] ext4: Allow sb to be NULL in ext4_msg()
=09[PATCH 06/17] ext4: move quota configuration out of
=09[PATCH 07/17] ext4: check ext2/3 compatibility outside
=09[PATCH 08/17] ext4: get rid of super block and sbi from
=09[PATCH 09/17] ext4: parse Opt_sb in handle_mount_opt()
=09[PATCH 10/17] ext4: clean up return values in handle_mount_opt()
=09[PATCH 11/17] ext4: mount api: add ext4_get_tree
=09[PATCH 12/17] ext4: refactor ext4_remount()
=09[PATCH 13/17] ext4: mount api: add ext4_reconfigure
=09[PATCH 14/17] ext4: mount api: add ext4_fc_free
=09[PATCH 15/17] ext4: mount api: switch to the new mount api
=09[PATCH 16/17] ext4: change token2str() to use ext4_param_specs
=09[PATCH 17/17] ext4: Remove unused code from old mount api


fs/ext4/super.c           | 1858 ++++++++++++++++++++++--------------
fs/fs_parser.c            |    5
include/linux/fs_parser.h |    6
3 files changed, 1147 insertions(+), 722 deletions(-)

