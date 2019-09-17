Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7720DB530A
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 18:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730399AbfIQQeX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 12:34:23 -0400
Received: from mail.thelounge.net ([91.118.73.15]:59717 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730330AbfIQQeU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Sep 2019 12:34:20 -0400
Received: from srv-rhsoft.rhsoft.net  (Authenticated sender: h.reindl@thelounge.net) by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 46XpbM6mf4zXqv;
        Tue, 17 Sep 2019 18:34:02 +0200 (CEST)
Subject: Re: Linux 5.3-rc8
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lennart Poettering <mzxreary@0pointer.de>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org>
 <20190917052438.GA26923@1wt.eu> <2508489.jOnZlRuxVn@merkaba>
 <20190917121156.GC6762@mit.edu>
 <20190917123015.sirlkvy335crozmj@debian-stretch-darwi.lab.linutronix.de>
 <20190917160844.GC31567@gardel-login>
 <CAHk-=wgsWTCZ=LPHi7BXzFCoWbyp3Ey-zZbaKzWixO91Ryr9=A@mail.gmail.com>
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
Message-ID: <75708f8d-b70e-a60e-15ce-faf02b47b3cd@thelounge.net>
Date:   Tue, 17 Sep 2019 18:34:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgsWTCZ=LPHi7BXzFCoWbyp3Ey-zZbaKzWixO91Ryr9=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



Am 17.09.19 um 18:23 schrieb Linus Torvalds:
> I do agree that a message is a good idea regardless, but I don't think
> it necessarily solves the problems except for developers

sadly in our current world dvelopers and maintainers don't read any logs
and as long it compiles and boots it works and can be pushed :-(

they even argue instead fix a dmaned line in a textfile which could have
been fixed 8 years in advance and i have written a ton of such reports
for F30 not talking about 15 others where software spits warnings with
the source file and line into the syslog and nobody out there gives a
damn about it

one example of many
https://bugzilla.redhat.com/show_bug.cgi?id=1748322

the only way you can get developers to clean up their mess these days is
to spit it straight into their face in modal window everytime they login
but how to exclude innocent endusers.....

half of my "rsyslog.conf" is to filter out stuff i can't fix anyways to
have my peace when call the script below every time i reboot whatever
linux machine

the 'usb_serial_init - returning with error' is BTW Linux when you boot
with 'nousb usbcore.nousb'

------------------

[root@srv-rhsoft:~]$ cat /scripts/system-errors.sh
#!/usr/bin/dash
dmesg -T | grep --color -i warn | grep -v 'Perf event create on CPU' |
grep -v 'Hardware RNG Device' | grep -v 'TPM RNG Device' | grep -v
'Correctable Errors collector initialized' | grep -v
'error=format-security' | grep -v 'MHD_USE_THREAD_PER_CONNECTION' | grep
-v 'usb_serial_init - returning with error' | grep -v
'systemd-journald.service' | grep -v 'usb_serial_init - registering
generic driver failed'
grep --color -i warn /var/log/messages | grep -v 'Perf event create on
CPU' | grep -v 'Hardware RNG Device' | grep -v 'TPM RNG Device' | grep
-v 'Correctable Errors collector initialized' | grep -v
'error=format-security' | grep -v 'MHD_USE_THREAD_PER_CONNECTION' | grep
-v 'usb_serial_init - returning with error' | grep -v
'systemd-journald.service' | grep -v 'usb_serial_init - registering
generic driver failed'
dmesg -T | grep --color -i fail | grep -v 'BAR 13' | grep -v 'Perf event
create on CPU' | grep -v 'Hardware RNG Device' | grep -v 'TPM RNG
Device' | grep -v 'Correctable Errors collector initialized' | grep -v
'error=format-security' | grep -v 'MHD_USE_THREAD_PER_CONNECTION' | grep
-v 'usb_serial_init - returning with error' | grep -v
'systemd-journald.service' | grep -v 'usb_serial_init - registering
generic driver failed'
grep --color -i fail /var/log/messages | grep -v 'BAR 13' | grep -v
'Perf event create on CPU' | grep -v 'Hardware RNG Device' | grep -v
'TPM RNG Device' | grep -v 'Correctable Errors collector initialized' |
grep -v 'error=format-security' | grep -v
'MHD_USE_THREAD_PER_CONNECTION' | grep -v 'usb_serial_init - returning
with error' | grep -v 'systemd-journald.service' | grep -v
'usb_serial_init - registering generic driver failed'
dmesg -T | grep --color -i error | grep -v 'Perf event create on CPU' |
grep -v 'Hardware RNG Device' | grep -v 'TPM RNG Device' | grep -v
'Correctable Errors collector initialized' | grep -v
'error=format-security' | grep -v 'MHD_USE_THREAD_PER_CONNECTION' | grep
-v 'usb_serial_init - returning with error' | grep -v
'systemd-journald.service' | grep -v 'usb_serial_init - registering
generic driver failed'
grep --color -i error /var/log/messages | grep -v 'Perf event create on
CPU' | grep -v 'Hardware RNG Device' | grep -v 'TPM RNG Device' | grep
-v 'Correctable Errors collector initialized' | grep -v
'error=format-security' | grep -v 'MHD_USE_THREAD_PER_CONNECTION' | grep
-v 'usb_serial_init - returning with error' | grep -v
'systemd-journald.service' | grep -v 'usb_serial_init - registering
generic driver failed'
grep --color -i "scheduling restart" /var/log/messages | grep -v
'systemd-journald.service'
[root@srv-rhsoft:~]$
