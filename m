Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACC882DC6B
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2019 14:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfE2MGL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 May 2019 08:06:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46708 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfE2MGK (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 29 May 2019 08:06:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2785481E14;
        Wed, 29 May 2019 12:06:10 +0000 (UTC)
Received: from work (unknown [10.43.17.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 42947600C4;
        Wed, 29 May 2019 12:06:08 +0000 (UTC)
Date:   Wed, 29 May 2019 14:06:03 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.com>, Theodore Ts'o <tytso@mit.edu>
Subject: How to package e2scrub
Message-ID: <20190529120603.xuet53xgs6ahfvpl@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 29 May 2019 12:06:10 +0000 (UTC)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi guys,

I am about to release 1.45.2 for Fedora rawhide, but I was thinking
about how to package the e2scrub cron job/systemd service.

I really do not like the idea of installing cron job and/or the service as
a part of regular e2fsprogs package. This can potentially really surprise
people in a bad way.

Note that I've already heard some complaints from debian users about the
systemd service being installed on their system after the e2fsprogs
update.

What I am going to do is to split the systemd service into a separate
package and I'd like to come to some agreement about the name of the
package so that we can have the same name across distributions (at least
Fedora/Debian/Suse).

I was thinking about e2scrub-service for systemd service or e2scrub-cron
for the cron job. What do you think ?

Also I decided not to package the cron job for now. But if I decide to
package it in the future I'd like to change the e2scrub cron
configuration so that it can run on the systems with systemd but make
the package conflict with the e2scrub-service so that users are free to
decide how they want to use it.

Thoughts ?

Thanks!
-Lukas
