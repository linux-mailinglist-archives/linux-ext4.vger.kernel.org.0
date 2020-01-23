Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29D3914714B
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jan 2020 20:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgAWTAW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Jan 2020 14:00:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48374 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgAWTAV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Jan 2020 14:00:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8HR2OlxtYSb8VdzQerDMMYUwatLK4APc/+QQpvP3lEg=; b=hl/QHk5iTlsDRKCfY+NHVGyfL
        qgqj7dYv7pKzurBROUVNuwRXpgmtf5xN3yRceVvnxS/eNW6WGHi95QfEo03tR4rTgkcR9wKIpjOmb
        81jLRVHYNsnKtfnjooWbbrFPxwX56OTZ63ybhx80bRhENoVrRLtGFmp5a9OL1jd8EGj42zKv99+eB
        JwtSr7fZ7Cz//tDfqUVR3E5tPEXA9q0ngG2/f56cyWSgnmbgWjx3we2vtNWgdwVb329LgskVc333M
        J503k7JhpQBbDcV/o75dUqL1juPCeAu+WcLSbMe1/lmAGA9E3WwrLYl6CMt5DUF3qozC89SWC/IFK
        whdtZUgpw==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iuhiE-0003BI-Ui; Thu, 23 Jan 2020 19:00:19 +0000
To:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Jan Kara <jack@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        Paul Mackerras <paulus@samba.org>, linux-ppp@vger.kernel.org,
        Jan Kara <jack@suse.com>, reiserfs-devel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs <linux-xfs@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: changes.rst: update several outdated project
 URLs
Message-ID: <efb1f518-9e66-c472-d124-4b7d91e56639@infradead.org>
Date:   Thu, 23 Jan 2020 11:00:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
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
Cc: Jan Kara <jack@suse.com>
Cc: reiserfs-devel@vger.kernel.org
Cc: Darrick J. Wong <darrick.wong@oracle.com>
Cc: linux-xfs@vger.kernel.org
---

 Documentation/process/changes.rst                    |   12 ++++++----
 Documentation/translations/it_IT/process/changes.rst |   12 ++++++----
 2 files changed, 16 insertions(+), 8 deletions(-)

diff -Naurp linux-next-20200123/Documentation/translations/it_IT/process/changes.rst%WWW linux-next-20200123/Documentation/translations/it_IT/process/changes.rst
--- linux-next-20200123/Documentation/translations/it_IT/process/changes.rst%WWW	2019-11-24 16:32:01.000000000 -0800
+++ linux-next-20200123/Documentation/translations/it_IT/process/changes.rst	2020-01-23 10:47:56.226457425 -0800
@@ -391,6 +391,8 @@ E2fsprogs
 ---------
 
 - <http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-1.29.tar.gz>
+- <https://www.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/>
+- <https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/>
 
 JFSutils
 --------
@@ -400,12 +402,12 @@ JFSutils
 Reiserfsprogs
 -------------
 
-- <http://www.kernel.org/pub/linux/utils/fs/reiserfs/>
+- <https://git.kernel.org/pub/scm/linux/kernel/git/jeffm/reiserfsprogs.git/>
 
 Xfsprogs
 --------
 
-- <ftp://oss.sgi.com/projects/xfs/>
+- <https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git>
 
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
diff -Naurp linux-next-20200123/Documentation/process/changes.rst%WWW linux-next-20200123/Documentation/process/changes.rst
--- linux-next-20200123/Documentation/process/changes.rst%WWW	2019-11-24 16:32:01.000000000 -0800
+++ linux-next-20200123/Documentation/process/changes.rst	2020-01-23 10:47:56.226457425 -0800
@@ -384,6 +384,8 @@ E2fsprogs
 ---------
 
 - <http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-1.29.tar.gz>
+- <https://www.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/>
+- <https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/>
 
 JFSutils
 --------
@@ -393,12 +395,12 @@ JFSutils
 Reiserfsprogs
 -------------
 
-- <http://www.kernel.org/pub/linux/utils/fs/reiserfs/>
+- <https://git.kernel.org/pub/scm/linux/kernel/git/jeffm/reiserfsprogs.git/>
 
 Xfsprogs
 --------
 
-- <ftp://oss.sgi.com/projects/xfs/>
+- <https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git>
 
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


