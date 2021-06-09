Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443603A0B6B
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Jun 2021 06:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbhFIEip (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Jun 2021 00:38:45 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:53133 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhFIEip (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Jun 2021 00:38:45 -0400
Received: (Authenticated sender: josh@joshtriplett.org)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 336C8240003;
        Wed,  9 Jun 2021 04:36:48 +0000 (UTC)
Date:   Tue, 8 Jun 2021 21:36:46 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca
Subject: mke2fs with size limit and default discard will discard data after
 size limit
Message-ID: <YMBFXi22cilZTPUk@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

mke2fs with a specified size and the default-enabled "discard" option
will discard data after that specified size. If using the size (and
potentially offset) to write a partition within a disk or disk image,
this will zero part of the following partition.

Steps to reproduce:

# Make a 128M disk filled with 0x0a, to see which bytes get written
yes '' | dd iflag=fullblock of=test.img bs=1M count=128
# Show the disk filled with 0x0a
hd test.img
# Make a 1M filesystem, which shouldn't touch the remaining 127M
mkfs.ext4 -b 4096 -I 256 test.img 1M
# Show the disk, which has had data discarded to the 16M boundary
hd test.img

This also applies if you pass an offset; for instance, passing
offset=4096 will discard data from 4096 to 16M+4096 before writing the
filesystem.

Passing -E nodiscard works around this; the remainder of e2fsprogs does
seem to avoid writing outside the bounds.

(Discovered via some debugging adventures with disk image building. Also
reported to Debian as https://bugs.debian.org/989630 since I first
encountered it there, but sending to linux-ext4 as a more appropriate
place for e2fsprogs bug reports.)

- Josh Triplett
