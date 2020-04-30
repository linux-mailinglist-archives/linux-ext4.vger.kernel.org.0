Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20131BF9EC
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Apr 2020 15:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgD3Nt0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Apr 2020 09:49:26 -0400
Received: from vpsf.regnarg.cz ([37.205.8.125]:50162 "EHLO vpsf.regnarg.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726577AbgD3NtZ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 30 Apr 2020 09:49:25 -0400
X-Greylist: delayed 313 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Apr 2020 09:49:25 EDT
Received: from baerbar.localdomain (unknown [10.17.17.20])
        by vpsf.regnarg.cz (Postfix) with ESMTPS id 14F17222D;
        Thu, 30 Apr 2020 15:44:11 +0200 (CEST)
Date:   Thu, 30 Apr 2020 15:44:09 +0200
From:   Filip =?utf-8?B?xaB0xJtkcm9uc2vDvQ==?= <r.lkml@regnarg.cz>
To:     linux-ext4@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>
Subject: Any way to dump ext4 filesystem without file data blocks? (for later
 analysis)
Message-ID: <20200430134409.i5cxmmnbryx5hbui@baerbar.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

I have experienced several mysterious ext4 issues on remote machines
with poor internet connection (mobile broadband) that are not easily
physically accessible.

I would like to download the filesystem image from the remote machine
for local investigation but the partition is rather large (500GB in
one instance) and I cannot easily upload that much data over the
mobile connection.

Is there any way to extract only filesystem metadata (superblock,
inodes, directory data blocks, etc.) from the partition but not
file data blocks? Ideally so that I could then reconstruct an
identical filesystem image, only with file data blocks zeroed out.

It seems it should be straightforwad to write such a tool but before
I start doing so, I wanted to check whether somebody hasn't already
written one. (It seems this might be a common enough need when
debugging and developing filesystems.) Short googling around and
searching list archive did not reveal anything.

Thanks for any pointers.

Filip Stedronsky
