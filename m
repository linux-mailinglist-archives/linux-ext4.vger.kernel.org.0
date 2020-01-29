Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E19AE14D36A
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Jan 2020 00:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgA2XPT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Jan 2020 18:15:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52452 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgA2XPT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Jan 2020 18:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YE5ymmg/Qoh5EFK9pVvYeClJYE682bbCQnrC66d+TOc=; b=hxaoehU77S1fZAy677mOd1sm1
        JjfnFRlZxbzaUUX53Ti75TXmkGdG7ltwdyqeib0jlXtiXKYLAqubtBIyQh9RF9pmtRUuvMoQhx4ON
        lZDuGYZNIdASkaBwDckHywVVyTOkSmI6rgb4VCbHm8cusVXnFx5zmAQFMMhbyrKyCXsZRMmlyhio5
        yXOc5zcqDiGjp3VZJHkF0/1i9A5i9i61s+4oayNZRySecQKFeNMUiPRvQHpg2TJ6Zl7ssEpLFrLgD
        wu3x2p4pbdKNN4Zi6AQRLwS5/IuCzWi5nCDhRX/Jk5hX/7YkSgCEnm0noXgupWgg91QCoQWp/d5R3
        qPFjnIM/A==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwwYH-0007Ig-Te; Wed, 29 Jan 2020 23:15:18 +0000
To:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Jan Kara <jack@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        Paul Mackerras <paulus@samba.org>, linux-ppp@vger.kernel.org,
        reiserfs-devel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs <linux-xfs@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] Documentation: changes.rst: update several outdated
 project URLs
Message-ID: <a9c3c509-8f30-fcc4-d9e0-b53aeaa89e4f@infradead.org>
Date:   Wed, 29 Jan 2020 15:15:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Update projects URLs in the changes.rst file.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Jan Kara <jack@suse.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org
Cc: coreteam@netfilter.org
Cc: Paul Mackerras <paulus@samba.org>
Cc: linux-ppp@vger.kernel.org
Cc: reiserfs-devel@vger.kernel.org
Cc: Darrick J. Wong <darrick.wong@oracle.com>
Cc: linux-xfs@vger.kernel.org
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Acked-by: Theodore Ts'o <tytso@mit.edu>
---
v2 changes:
. add Ack and Review tags;
. update as requested by Darrick and Ted;

 Documentation/process/changes.rst                    |   14 ++++++----
 Documentation/translations/it_IT/process/changes.rst |   14 ++++++----
 2 files changed, 18 insertions(+), 10 deletions(-)

--- linux-next-20200129.orig/Documentation/translations/it_IT/process/changes.rst
+++ linux-next-20200129/Documentation/translations/it_IT/process/changes.rst
@@ -390,7 +390,8 @@ Mkinitrd
 E2fsprogs
 ---------
 
-- <http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-1.29.tar.gz>
+- <https://www.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/>
+- <https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/>
 
 JFSutils
 --------
@@ -400,12 +401,13 @@ JFSutils
 Reiserfsprogs
 -------------
 
-- <http://www.kernel.org/pub/linux/utils/fs/reiserfs/>
+- <https://git.kernel.org/pub/scm/linux/kernel/git/jeffm/reiserfsprogs.git/>
 
 Xfsprogs
 --------
 
-- <ftp://oss.sgi.com/projects/xfs/>
+- <https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git>
+- <https://www.kernel.org/pub/linux/utils/fs/xfs/xfsprogs/>
 
 Pcmciautils
 -----------
@@ -444,7 +446,9 @@ Rete
 PPP
 ---
 
-- <ftp://ftp.samba.org/pub/ppp/>
+- <https://download.samba.org/pub/ppp/>
+- <https://git.ozlabs.org/?p=ppp.git>
+- <https://github.com/paulusmack/ppp/>
 
 
 NFS-utils
@@ -455,7 +459,7 @@ NFS-utils
 Iptables
 --------
 
-- <http://www.iptables.org/downloads.html>
+- <https://netfilter.org/projects/iptables/index.html>
 
 Ip-route2
 ---------
--- linux-next-20200129.orig/Documentation/process/changes.rst
+++ linux-next-20200129/Documentation/process/changes.rst
@@ -383,7 +383,8 @@ Mkinitrd
 E2fsprogs
 ---------
 
-- <http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-1.29.tar.gz>
+- <https://www.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/>
+- <https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/>
 
 JFSutils
 --------
@@ -393,12 +394,13 @@ JFSutils
 Reiserfsprogs
 -------------
 
-- <http://www.kernel.org/pub/linux/utils/fs/reiserfs/>
+- <https://git.kernel.org/pub/scm/linux/kernel/git/jeffm/reiserfsprogs.git/>
 
 Xfsprogs
 --------
 
-- <ftp://oss.sgi.com/projects/xfs/>
+- <https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git>
+- <https://www.kernel.org/pub/linux/utils/fs/xfs/xfsprogs/>
 
 Pcmciautils
 -----------
@@ -437,7 +439,9 @@ Networking
 PPP
 ---
 
-- <ftp://ftp.samba.org/pub/ppp/>
+- <https://download.samba.org/pub/ppp/>
+- <https://git.ozlabs.org/?p=ppp.git>
+- <https://github.com/paulusmack/ppp/>
 
 NFS-utils
 ---------
@@ -447,7 +451,7 @@ NFS-utils
 Iptables
 --------
 
-- <http://www.iptables.org/downloads.html>
+- <https://netfilter.org/projects/iptables/index.html>
 
 Ip-route2
 ---------

