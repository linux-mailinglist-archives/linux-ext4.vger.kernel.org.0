Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C7135FCD8
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Apr 2021 22:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347039AbhDNUrv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Apr 2021 16:47:51 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40567 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231415AbhDNUru (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Apr 2021 16:47:50 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13EKlADN000584
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Apr 2021 16:47:11 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6AEE915C3B35; Wed, 14 Apr 2021 16:47:10 -0400 (EDT)
Date:   Wed, 14 Apr 2021 16:47:10 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Eryu Guan <guan@eryu.me>, Christian Brauner <brauner@kernel.org>,
        fstests@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-ext4@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH -RFC] ext4: add feature file to advertise that ext4 supports
 idmapped mounts
Message-ID: <YHdUzqZ7PZtb64zf@mit.edu>
References: <20210328223400.1800301-1-brauner@kernel.org>
 <20210328223400.1800301-3-brauner@kernel.org>
 <YHMH/JRmzg3ETcED@desktop>
 <20210411151249.6y34x7yatqtpcvi6@wittgenstein>
 <20210411151857.wd6gd46u53vlh2xv@wittgenstein>
 <YHMUAL/oD4fB3+R7@desktop>
 <20210411153223.vhcegiklrwoczy55@wittgenstein>
 <YHOW7DN51YuYgLPM@mit.edu>
 <20210412115426.a4bzsx4cp7jhx2ou@wittgenstein>
 <YHTMkBcVTFAGqyks@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHTMkBcVTFAGqyks@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 12, 2021 at 06:41:20PM -0400, Theodore Ts'o wrote:
> In the ideal world, if the kernel wasn't compiled with the necessary
> CONFIG options enabled, it's desirable of the test can detect that
> fact and skip running the test instead failing and forcing the person
> running the test to try to figure out whether this is a legitmate file
> system bug or a just a test setup bug.

So it would make it easier for me to manage running xfstests on ext4
if I had added something like this to ext4 and sent it to Linus before
v5.12 is released.  What do folks think?

							- Ted


commit 20619aefe69d39e76083d8f8598653c2dca9b47e
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Wed Apr 14 16:42:47 2021 -0400

    ext4: add feature file to advertise that ext4 supports idmapped mounts
    
    This makes it easier for automated test suites to know whether it know
    whether we should test the functionality of the new idmapped mounts
    feature introduced in v5.12-rc1.
    
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index a3d08276d441..101bf700c16b 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -313,6 +313,9 @@ EXT4_ATTR_FEATURE(verity);
 #endif
 EXT4_ATTR_FEATURE(metadata_csum_seed);
 EXT4_ATTR_FEATURE(fast_commit);
+#ifdef CONFIG_USER_NS
+EXT4_ATTR_FEATURE(idmapped_mount);
+#endif
 
 static struct attribute *ext4_feat_attrs[] = {
 	ATTR_LIST(lazy_itable_init),
@@ -330,6 +333,9 @@ static struct attribute *ext4_feat_attrs[] = {
 #endif
 	ATTR_LIST(metadata_csum_seed),
 	ATTR_LIST(fast_commit),
+#ifdef CONFIG_USER_NS
+	ATTR_LIST(idmapped_mount),
+#endif
 	NULL,
 };
 ATTRIBUTE_GROUPS(ext4_feat);
