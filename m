Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFEE0116B81
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Dec 2019 11:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfLIKyc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Dec 2019 05:54:32 -0500
Received: from relay.sw.ru ([185.231.240.75]:59402 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbfLIKyc (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 9 Dec 2019 05:54:32 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1ieGgK-0002mk-9e; Mon, 09 Dec 2019 13:54:24 +0300
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jack@suse.com, adilger.kernel@dilger.ca,
        ktkhai@virtuozzo.com
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: [Q] e4defrag and append-only files
Message-ID: <a2b2fcf4-4b71-e78c-5a10-627097df44fb@virtuozzo.com>
Date:   Mon, 9 Dec 2019 13:54:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

on one of production nodes I observe the situation, when many fragmented files
never become defragmented, becase of they have "a" extended attribute.
The reason is append-only file can't be open for write without O_APPEND attribute:

$lsattr a.txt
-----a--------e----- a.txt

$strace e4defrag a.txt
openat(AT_FDCWD, "a.txt", O_RDWR)       = -1 EPERM (Operation not permitted)

Simple O_APPEND passed to open() solves the situation.

The question is: can't we just do this?

Let's observe the file restrictions we may have.

"Append-only" extended attribute restriction is weaker, than RO file permissions (0444).
But RO files are being processed by e4defrag, since e4defrag runs by root, and it easily
ignores RO file permissions, while "append-only" files are always ignored by the util.
Is there a fundamental reason we must skip them?

Thanks,
Kirill
