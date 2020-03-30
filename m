Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4754619777A
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Mar 2020 11:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbgC3JJh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Mar 2020 05:09:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:39836 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729768AbgC3JJh (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 30 Mar 2020 05:09:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 89704AEB8;
        Mon, 30 Mar 2020 09:09:36 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F32D71E0E20; Mon, 30 Mar 2020 11:09:35 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2] Fixes for dir_index support in libext2fs
Date:   Mon, 30 Mar 2020 11:09:30 +0200
Message-Id: <20200330090932.29445-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

here are two small fixes that I've spotted in the new support for adding
entries into indexed directories.

								Honza
