Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72108306BF3
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Jan 2021 05:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhA1EKA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Jan 2021 23:10:00 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51479 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229530AbhA1EJw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Jan 2021 23:09:52 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 10S48xaa011177
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jan 2021 23:08:59 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C8D4C15C344F; Wed, 27 Jan 2021 23:08:58 -0500 (EST)
Date:   Wed, 27 Jan 2021 23:08:58 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc:     linux-ext4@vger.kernel.org, drosen@google.com,
        krisman@collabora.com, ebiggers@kernel.org
Subject: Re: [PATCH v3 12/12] tests: f_bad_fname: Test fixes of invalid
 filenames and duplicates
Message-ID: <YBI42sG2VcE25h4h@mit.edu>
References: <20201217173544.52953-1-arnaud.ferraris@collabora.com>
 <20201217173544.52953-13-arnaud.ferraris@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217173544.52953-13-arnaud.ferraris@collabora.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 17, 2020 at 06:35:44PM +0100, Arnaud Ferraris wrote:
> From: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>

It looks like you didn't regenerate the expect.1 file after changing
the problem description.

% cat f_bad_fname.failed 
--- /usr/projects/e2fsprogs/e2fsprogs/tests/f_bad_fname/expect.1	2021-01-28 03:20:36.813595045 +0000
+++ f_bad_fname.1.log	2021-01-28 03:25:49.940137813 +0000
@@ -1,9 +1,9 @@
 Pass 1: Checking inodes, blocks, and sizes
 Pass 2: Checking directory structure
-Entry 'AM-^?' in /ci_dir (12) has illegal characters in its name.
+Entry 'AM-^?' in /ci_dir (12) has illegal UTF-8 characters in its name.
 Fix? yes
 
-Entry 'AM-~' in /ci_dir (12) has illegal characters in its name.
+Entry 'AM-~' in /ci_dir (12) has illegal UTF-8 characters in its name.
 Fix? yes
 
 Duplicate entry 'A.' found.

I'll fix this up in my tree.

     	           	      	       - Ted
