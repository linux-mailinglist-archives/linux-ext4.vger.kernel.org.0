Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF69848A103
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Jan 2022 21:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240243AbiAJUkO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 Jan 2022 15:40:14 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58393 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234477AbiAJUkO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 10 Jan 2022 15:40:14 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 20AKeB9L010233
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jan 2022 15:40:11 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 26C6815C00C8; Mon, 10 Jan 2022 15:40:11 -0500 (EST)
Date:   Mon, 10 Jan 2022 15:40:11 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Announcement: new version of the {kvm,gce}-xfstests appliance
Message-ID: <YdyZqwIPA8KX6bYm@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

To celebrate the new year, I've uploaded an updated version of the
test appliance used by kvm-xfstests and gce-xfstests.  The
kvm-xfstests root_fs can be found at:

     https://kernel.org/pub/linux/kernel/people/tytso/kvm-xfstests

The gce-xfstests image can be found in the xfstests-cloud project in
Google Compute Engine with the image name xfstests-202201091923.  Most
people who request their gce-xfstests image from the xfstests-cloud
project will get the latest version automatically.

The major change in this latest version of the test appliance is that
it is now based on Debian Bullseye, the latest Debian stable release,
which was released in August 2021.  For people who have been doing
their test development using kvm-xfstests or gce-xfstesets, you should
rerun the setup-buildchroot script, which now defaults to creating a
build chroot using Debian Bullseye.

The test appliance was based on these components:

blktests	3be7849 (Tue, 19 Oct 2021 12:22:17 -0700)
e2fsprogs	v1.46.4-27-g6b7a6e4a (Thu, 4 Nov 2021 20:29:19 -0400)
fio		fio-3.29 (Sat, 18 Dec 2021 07:09:32 -0700)
fsverity	v1.4-4-gddc6bc9 (Wed, 22 Sep 2021 11:55:11 -0700)
ima-evm-utils	v1.3.2 (Wed, 28 Oct 2020 13:18:08 -0400)
nvme-cli	v1.16 (Thu, 11 Nov 2021 13:09:06 -0800)
quota		v4.05-43-gd2256ac (Fri, 17 Sep 2021 14:04:16 +0200)
util-linux	v2.37.2 (Mon, 16 Aug 2021 15:23:50 +0200)
xfsprogs	v5.13.0 (Fri, 20 Aug 2021 12:03:57 -0400)
xfstests-bld	8b681c94 (Sat, 8 Jan 2022 22:20:42 -0500)
xfstests	linux-v3.8-3438-gf0a05db9 (Sun, 9 Jan 2022 18:58:11 -0500)

with local changes to xfstests not yet pushed upstream found here:

    https://github.com/tytso/xfstests release-2022-01-09-f0a05db9

The test appliance sources can be found at

     https://github.com/tytso/xfstests-bld

						- Ted
