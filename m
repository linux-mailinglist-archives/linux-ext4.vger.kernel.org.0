Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8866B121FED
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Dec 2019 01:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfLQAoV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Dec 2019 19:44:21 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:35220 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfLQAoV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Dec 2019 19:44:21 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ih0yJ-00022g-O0; Tue, 17 Dec 2019 00:44:20 +0000
Date:   Tue, 17 Dec 2019 00:44:19 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 02/17] ext4: Add fs parameter description
Message-ID: <20191217004419.GA6833@ZenIV.linux.org.uk>
References: <20191106101457.11237-1-lczerner@redhat.com>
 <20191106101457.11237-3-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106101457.11237-3-lczerner@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 06, 2019 at 11:14:42AM +0100, Lukas Czerner wrote:
> +	fsparam_string_empty
> +			("usrjquota",		Opt_usrjquota),
> +	fsparam_string_empty
> +			("grpjquota",		Opt_grpjquota),

Umm...  That makes ...,usrjquota,... equivalent to ...,usrjquota=,...
unless I'm misreading the series.  Different from mainline, right?

> +	fsparam_bool	("barrier",		Opt_barrier),
> +	fsparam_flag	("nobarrier",		Opt_nobarrier),

That's even more interesting.  Current mainline:
		barrier		OK, sets EXT4_MOUNT_BARRIER
		barrier=0	OK, sets EXT4_MOUNT_BARRIER
		barrier=42	OK, sets EXT4_MOUNT_BARRIER
		barrier=yes	error
		barrier=no	error
		nobarrier	OK, clears EXT4_MOUNT_BARRIER
Unless I'm misreading your series, you get
		barrier		error
		barrier=0	OK, sets EXT4_MOUNT_BARRIER
		barrier=42	error
		barrier=yes	OK, sets EXT4_MOUNT_BARRIER
		barrier=no	OK, sets EXT4_MOUNT_BARRIER
		nobarrier	OK, clears EXT4_MOUNT_BARRIER

Granted, mainline behaviour is... unintuitive, to put it mildly,
but the replacement is just as strange _and_ incompatible with the
existing one.

Am I missing something subtle there?
