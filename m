Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3573FF6DE
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Sep 2021 00:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbhIBWK1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Sep 2021 18:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhIBWK0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Sep 2021 18:10:26 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8F3C061575;
        Thu,  2 Sep 2021 15:09:27 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:104d:444a:d152:279d:1dbb])
        by ms.lwn.net (Postfix) with ESMTPA id DE0E96178;
        Thu,  2 Sep 2021 22:09:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DE0E96178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1630620560; bh=TIC/ao/E9wRbKC4FXC/B5dXsWLkiT9LwWYVZT0UFGJg=;
        h=From:To:Cc:Subject:Date:From;
        b=isLITBUmC28yZfEnbX1KJhMnG6wpoBt9Y6SpBpxbIuEl+Dyem9dT7aLtd/n1As3wX
         Itgkrp+eQYL+H0WvfWAdrDhp3W/run+sQMWBaxWnRPaIuI9gwArVqsHlolh2uXG2kb
         5bKyz0u+K8UcFThABD5mITWIUQsxacMOnmxN6yUII6UfFainI07MEWTa6FNQhwkd2J
         FutQPrWd0+a+YevBiiu9kCzEtjF6fByc7sovS8naomRhCqCPS2T157TPHrtx7K6Uhf
         wkAy9R+zV/SQWBySDwamo2bxYqSIYVNOQEFNPJwJhUL2glCYbVoAH5uNdz6OaPSz9H
         wH2d0BcDYUSdQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 0/2] ext4: docs: de-uglify Documentation/ext4/orphan.rst
Date:   Thu,  2 Sep 2021 16:08:52 -0600
Message-Id: <20210902220854.198850-1-corbet@lwn.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I happened to see the new orphan.rst file go by and noticed it contains a
couple of pathologies that make the file far harder to read than it really
needs to be.  These patches fix things up and, hopefully, serve as a
template for equivalent changes elsewhere in this directory.

Jonathan Corbet (2):
  ext4: docs: switch away from list-table
  ext4: docs: Take out unneeded escaping

 Documentation/filesystems/ext4/orphan.rst | 44 +++++++++--------------
 1 file changed, 17 insertions(+), 27 deletions(-)

-- 
2.31.1

