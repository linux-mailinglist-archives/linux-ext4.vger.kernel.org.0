Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72298468D57
	for <lists+linux-ext4@lfdr.de>; Sun,  5 Dec 2021 21:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238761AbhLEUsp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 5 Dec 2021 15:48:45 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60417 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238373AbhLEUsp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 5 Dec 2021 15:48:45 -0500
Received: from callcc.thunk.org ([63.85.23.26])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1B5Kiwvs012512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 5 Dec 2021 15:44:59 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 474674205DB; Sun,  5 Dec 2021 15:44:58 -0500 (EST)
Date:   Sun, 5 Dec 2021 15:44:58 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Wenqing Liu <liu@cs.fsu.edu>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Page fault in fs/ext4/namei.c: do_split when crafted image is
 mounted and operated
Message-ID: <Ya0kyhDD5zJMQ0oV@mit.edu>
References: <8b0561482e1c3b765282a109a7a12593@cs.fsu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b0561482e1c3b765282a109a7a12593@cs.fsu.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Dec 04, 2021 at 02:17:52PM -0500, Wenqing Liu wrote:
> - Overview
> Page fault in fs/ext4/namei.c: do_split when crafted image is mounted and
> operated

This looks like another dup of these reports:

Message-ID: <CA+AJg7OHrVgbHuRi5Sqyt5v1PzN-OhG8NjKaanLY-_+OZPvkDA@mail.gmail.com>
Message-ID: <CA+AJg7NwCgxw65JbyWLbbq4aP-vbBzFMEn-=k6DrdTpWMBQbxQ@mail.gmail.com>

							- Ted
