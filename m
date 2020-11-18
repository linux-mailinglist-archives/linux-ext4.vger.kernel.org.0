Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14762B7B50
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 11:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgKRKac convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Wed, 18 Nov 2020 05:30:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:46104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgKRKac (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 18 Nov 2020 05:30:32 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 210185] kernel BUG at fs/ext4/page-io.c:126!
Date:   Wed, 18 Nov 2020 10:30:31 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: emchroma@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-210185-13602-LM8XHz3BnI@https.bugzilla.kernel.org/>
In-Reply-To: <bug-210185-13602@https.bugzilla.kernel.org/>
References: <bug-210185-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=210185

--- Comment #4 from emchroma@gmail.com ---
(In reply to Theodore Tso from comment #3)

Hi Theodore,

> How easily can you reproduce the problem?  

on each invocation.

> Can you give us instructions for a reliable repro (e.g., download AutoCtk,
> run it with these options and this input file, and it will crash in N
> minutes)?

You'll need Anaconda, Ngspice and AutoCkt. I'm on debian and I've apt-get
ngspice. I'll try a step by step procedure for Anaconda and AutoCkt

We're using https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh
Download and install Anaconda

# activate base environment
$ . .bashrc

# upgrade pip
$ pip install --upgrade pip

# download AutoCkt
$ git clone https://github.com/ksettaluri6/AutoCkt.git

# create autockt_updated environment, use the attached autockt_updated.yml,
# not the environment provided by AutoCkt
$ conda env create -f autockt_updated.yml

# activate environment autockt_upgraded
$ conda activate autockt_updated

# copy the attached parameter file to AutoCkt/autockt
$ cp val_autobag_ray_hyperparameter_tuning.py AutoCkt/autockt

# run AutoCkt
$ cd AutoCkt
$ python autockt/gen_specs.py --num_specs 600
$ ipython
$ run autockt/val_autobag_ray_hyperparameter_tuning.py # this is in the IPython
shell

AutoCkt creates a lot of files in /tmp/ckt_da and /tmp/ray. tmp is on the root
partition and
our root is rather small (100G), therefore we start a python script to delete
files/directories
older than 10 minutes in /tmp/ckt_da from a second shell

# cleanup /tmp/ckt_da
$ python auto_delete_old_tmp_ckt_da_files.py

AutoCkt is very verbose and you'll probably see some warnings, but it should
run. On our machines
it usually takes 10-15 minutes, sometimes up to 30 minutes until the bug
appears.

Not sure whether it matters, but we're using software raid1 for the root
partition.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
