Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D10356AAF
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Jun 2019 15:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfFZNfR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Jun 2019 09:35:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53646 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfFZNfR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Jun 2019 09:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PDR0OUH+l8W0FfPhG2cU875eCqJsbiz49DJrT3EzeCU=; b=V9gh8c4t3lX2HIkwVst972Iau
        zCEUoYDJaoZ5CX9KtXrABCuI00mqavwLcNiE5RxFA8+Gl7xUu+/Xthw/ZdjSE4TUSdJgQaCQXjTN/
        FQ3sIFmjDGVM3y58fESFFkvJt3muS7uXDCDbms1yoqpj4JSFxCgpQQUW9OV9Rtn9oYvOufD+/YnSn
        I6uSFAgIEXqFT9K4tzncR05AlKlv5b+4wFtjgwpgcQD0EhlwiP1ewsjzeMU8T1Fh1hkOWFbRiUGee
        Fdfa4neKgWKW1z1f5BUBFiMmgX1QEng7nLqQ+9CP7ebB8/W3f1MSddS2N2Ldo81EgmLt577OQswtr
        l5csJc6Vw==;
Received: from 177.205.71.220.dynamic.adsl.gvt.net.br ([177.205.71.220] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hg84w-0003uf-SL; Wed, 26 Jun 2019 13:35:14 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hg84t-0003Pb-Vz; Wed, 26 Jun 2019 10:35:12 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        NeilBrown <neilb@suse.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        linux-ext4@vger.kernel.org
Subject: [PATCH] docs: filesystems: Remove uneeded .rst extension on toctables
Date:   Wed, 26 Jun 2019 10:35:11 -0300
Message-Id: <d2e4dfee7708a3ef6130d3ffcc579429de6a05c9.1561556105.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There's no need to use a .rst on Sphinx toc tables. As most of
the Documentation don't use, remove the remaing occurrences.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/filesystems/ext4/index.rst | 8 ++++----
 Documentation/filesystems/index.rst      | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/filesystems/ext4/index.rst b/Documentation/filesystems/ext4/index.rst
index 3be3e54d480d..705d813d558f 100644
--- a/Documentation/filesystems/ext4/index.rst
+++ b/Documentation/filesystems/ext4/index.rst
@@ -8,7 +8,7 @@ ext4 Data Structures and Algorithms
    :maxdepth: 6
    :numbered:
 
-   about.rst
-   overview.rst
-   globals.rst
-   dynamic.rst
+   about
+   overview
+   globals
+   dynamic
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 35644840a690..1651173f1118 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -17,7 +17,7 @@ algorithms work.
    :maxdepth: 2
 
    vfs
-   path-lookup.rst
+   path-lookup
    api-summary
    splice
 
@@ -41,4 +41,4 @@ Documentation for individual filesystem types can be found here.
 .. toctree::
    :maxdepth: 2
 
-   binderfs.rst
+   binderfs
-- 
2.21.0

