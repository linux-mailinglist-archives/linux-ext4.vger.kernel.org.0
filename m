Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 965204FAE7
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Jun 2019 11:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfFWJVg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 23 Jun 2019 05:21:36 -0400
Received: from leonardo.netwichtig.de ([213.133.111.59]:38141 "EHLO
        leonardo.netwichtig.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfFWJVg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 23 Jun 2019 05:21:36 -0400
X-Greylist: delayed 2400 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Jun 2019 05:21:33 EDT
Received: from [2001:1620:ae4:164:129a:ddff:fe9d:bff2] (port=57686 helo=frustcomp.hnjs.home.arpa)
        by leonardo.netwichtig.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux-ext4@henk.geekmail.org>)
        id 1hey3y-0004RZ-Se
        for linux-ext4@vger.kernel.org; Sun, 23 Jun 2019 10:41:30 +0200
Date:   Sun, 23 Jun 2019 10:41:03 +0200
From:   Hendrik Jaeger <linux-ext4@henk.geekmail.org>
To:     linux-ext4@vger.kernel.org
Subject: Kernel warnings about iov_iter_copy_from_user_atomic
Message-ID: <20190623104103.728b03f7@frustcomp.hnjs.home.arpa>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/gMFNIWEVCXqI/Tn.S_YZpks"; protocol="application/pgp-signature"
X-hnjs-Spam_score: -2.9
X-hnjs-Spam_score_int: -28
X-hnjs-Spam_bar: --
X-hnjs-Spam_report: Spam detection software, running on the system "leonardo.netwichtig.de",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
X-hnjs-domain-score: 0
X-hnjs-ip-score: 0
X-hnjs-inconsistency-score: 0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--Sig_/gMFNIWEVCXqI/Tn.S_YZpks
Content-Type: multipart/mixed; boundary="MP_/JOtty=tNM=EsoS93KPlhdc="

--MP_/JOtty=tNM=EsoS93KPlhdc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi

I recently got the attached messages in my logs and was told I should
report them to this list.

Thank you and best regards

Hendrik J=C3=A4ger

--MP_/JOtty=tNM=EsoS93KPlhdc=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="kernel-error-2019-07-21T01:07:27.txt"

Jun 21 01:07:27 leonardo kernel: [1922726.427128] WARNING: CPU: 1 PID: 2286=
 at /build/linux-fbsBhH/linux-4.19.37/lib/iov_iter.c:825 iov_iter_copy_from=
_user_atomic+0x130/0x2c0
Jun 21 01:07:27 leonardo kernel: [1922726.430268] Modules linked in: fuse b=
trfs zstd_compress zstd_decompress xxhash xor raid6_pq ufs qnx4 hfsplus hfs=
 minix vfat msdos fat jfs xfs tcp_diag udp_diag inet_diag unix_diag xt_comm=
ent nf_log_ipv6 ip6t_REJECT nf_reject_ipv6 ip6table_filter ip6_tables nf_lo=
g_ipv4 nf_log_common xt_LOG xt_limit ipt_REJECT nf_reject_ipv4 xt_tcpudp xt=
_recent xt_conntrack iptable_filter iptable_mangle iptable_nat nf_nat_ipv4 =
nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_raw ip_=
tablesx_tables snd_hda_codec_hdmi f71882fg eeprom dm_crypt dm_mod snd_hda_i=
ntel snd_hda_codec edac_mce_amd snd_hda_core radeon snd_hwdep kvm_amd kvm s=
nd_pcm joydev evdev sg irqbypass snd_timer ttm k8temp drm_kms_helper snd pc=
spkr serio_raw drm i2c_algo_bit soundcore sp5100_tco button ext4 crc16 mbca=
che jbd2 crc32c_generic
Jun 21 01:07:27 leonardo kernel: [1922726.430268]  fscrypto ecb crypto_simd=
 cryptd aes_i586 hid_generic usbhid hid sd_mod ata_generic ohci_pci psmouse=
 r8169 ahci i2c_piix4 pata_atiixp libahci libata realtek libphy ehci_pci sc=
si_mod ohci_hcd ehci_hcd usbcore usb_common
Jun 21 01:07:27 leonardo kernel: [1922726.430268] CPU: 1 PID: 2286 Comm: ic=
inga Not tainted 4.19.0-0.bpo.5-686-pae #1 Debian 4.19.37-3~bpo9+1
Jun 21 01:07:27 leonardo kernel: [1922726.430268] Hardware name: MICRO-STAR=
 INTERANTIONAL CO.,LTD MS-7368/MS-7368, BIOS V1.5B2 10/31/2007
Jun 21 01:07:27 leonardo kernel: [1922726.430268] EIP: iov_iter_copy_from_u=
ser_atomic+0x130/0x2c0
Jun 21 01:07:27 leonardo kernel: [1922726.430268] Code: 04 85 f6 0f 84 5d 0=
1 00 00 8b 45 f0 89 f1 8d 14 30 89 55 f0 8b 13 e8 ff e8 ff ff 29 c6 29 f7 e=
b a1 89 f6 8d bc 27 00 00 00 00 <0f> 0b 8b 45 e4 31 db e8 d4 13 cf ff 8d 65=
 f4 89 d8 5b 5e 5f 5d c3
Jun 21 01:07:27 leonardo kernel: [1922726.430268] EAX: 00001000 EBX: ff1782=
c0 ECX: 00000216 EDX: 80000039
Jun 21 01:07:27 leonardo kernel: [1922726.430268] ESI: f533e518 EDI: 000002=
80 EBP: c81e1d30 ESP: c81e1d10
Jun 21 01:07:27 leonardo kernel: [1922726.430268] DS: 007b ES: 007b FS: 00d=
8 GS: 00e0 SS: 0068 EFLAGS: 00010203
Jun 21 01:07:27 leonardo kernel: [1922726.430268] CR0: 80050033 CR2: 02514f=
40 CR3: 0fa46000 CR4: 000006f0
Jun 21 01:07:27 leonardo kernel: [1922726.430268] Call Trace:
Jun 21 01:07:27 leonardo kernel: [1922726.430268]  ? generic_perform_write+=
0xa0/0x1a0
Jun 21 01:07:27 leonardo kernel: [1922726.430268]  generic_perform_write+0x=
c2/0x1a0
Jun 21 01:07:27 leonardo kernel: [1922726.430268]  __generic_file_write_ite=
r+0x183/0x1d0
Jun 21 01:07:27 leonardo kernel: [1922726.430268]  ext4_file_write_iter+0xb=
4/0x520 [ext4]
Jun 21 01:07:27 leonardo kernel: [1922726.430268]  new_sync_write+0xdf/0x160
Jun 21 01:07:27 leonardo kernel: [1922726.430268]  ? ext4_file_mmap+0xa0/0x=
a0 [ext4]
Jun 21 01:07:27 leonardo kernel: [1922726.430268]  __vfs_write+0x37/0x50
Jun 21 01:07:27 leonardo kernel: [1922726.430268]  __kernel_write+0x51/0x100
Jun 21 01:07:27 leonardo kernel: [1922726.430268]  do_acct_process+0x4ed/0x=
610
Jun 21 01:07:27 leonardo kernel: [1922726.430268]  acct_process+0xb7/0x100
Jun 21 01:07:27 leonardo kernel: [1922726.430268]  do_exit+0x6f8/0xae0
Jun 21 01:07:27 leonardo kernel: [1922726.430268]  ? __do_page_fault+0x1fd/=
0x500
Jun 21 01:07:27 leonardo kernel: [1922726.430268]  do_group_exit+0x35/0x90
Jun 21 01:07:27 leonardo kernel: [1922726.430268]  sys_exit_group+0x16/0x20
Jun 21 01:07:27 leonardo kernel: [1922726.430268]  do_fast_syscall_32+0x7e/=
0x1c0
Jun 21 01:07:27 leonardo kernel: [1922726.430268]  entry_SYSENTER_32+0x6b/0=
xbe
Jun 21 01:07:27 leonardo kernel: [1922726.430268] EIP: 0xb7f1ed39
Jun 21 01:07:27 leonardo kernel: [1922726.430268] Code: Bad RIP value.
Jun 21 01:07:27 leonardo kernel: [1922726.430268] EAX: ffffffda EBX: 000000=
00 ECX: 00000000 EDX: 00000000
Jun 21 01:07:27 leonardo kernel: [1922726.430268] ESI: 02520b08 EDI: 000000=
00 EBP: 0050af20 ESP: bfb1ebcc
Jun 21 01:07:27 leonardo kernel: [1922726.430268] DS: 007b ES: 007b FS: 000=
0 GS: 0033 SS: 007b EFLAGS: 00000246
Jun 21 01:07:27 leonardo kernel: [1922726.430268] ---[ end trace c76fe0b987=
3e4612 ]---

--MP_/JOtty=tNM=EsoS93KPlhdc=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="kernel-error-2019-07-21T05:25:07.txt"

Jun 21 05:25:07 leonardo kernel: [1938186.326369] WARNING: CPU: 1 PID: 7034=
 at /build/linux-fbsBhH/linux-4.19.37/lib/iov_iter.c:825 iov_iter_copy_from=
_user_atomic+0x130/0x2c0
Jun 21 05:25:07 leonardo kernel: [1938186.328379] Modules linked in: fuse b=
trfs zstd_compress zstd_decompress xxhash xor raid6_pq ufs qnx4 hfsplus hfs=
 minix vfat msdos fat jfs xfs tcp_diag udp_diag inet_diag unix_diag xt_comm=
ent nf_log_ipv6 ip6t_REJECT nf_reject_ipv6 ip6table_filter ip6_tables nf_lo=
g_ipv4 nf_log_common xt_LOG xt_limit ipt_REJECT nf_reject_ipv4 xt_tcpudp xt=
_recent xt_conntrack iptable_filter iptable_mangle iptable_nat nf_nat_ipv4 =
nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_raw ip_=
tables x_tables snd_hda_codec_hdmi f71882fg eeprom dm_crypt dm_mod snd_hda_=
intel snd_hda_codec edac_mce_amd snd_hda_core radeon snd_hwdep kvm_amd kvm =
snd_pcm joydev evdev sg irqbypass snd_timer ttm k8temp drm_kms_helper snd p=
cspkr serio_raw drm i2c_algo_bit soundcore sp5100_tco button ext4 crc16 mbc=
ache jbd2 crc32c_generic
Jun 21 05:25:07 leonardo kernel: [1938186.328379]  fscrypto ecb crypto_simd=
 cryptd aes_i586 hid_generic usbhid hid sd_mod ata_generic ohci_pci psmouse=
 r8169 ahci i2c_piix4 pata_atiixp libahci libata realtek libphy ehci_pci sc=
si_mod ohci_hcd ehci_hcd usbcore usb_common
Jun 21 05:25:07 leonardo kernel: [1938186.328379] CPU: 1 PID: 7034 Comm: ic=
inga Tainted: G        W         4.19.0-0.bpo.5-686-pae #1 Debian 4.19.37-3=
~bpo9+1
Jun 21 05:25:07 leonardo kernel: [1938186.328379] Hardware name: MICRO-STAR=
 INTERANTIONAL CO.,LTD MS-7368/MS-7368, BIOS V1.5B2 10/31/2007
Jun 21 05:25:07 leonardo kernel: [1938186.328379] EIP: iov_iter_copy_from_u=
ser_atomic+0x130/0x2c0
Jun 21 05:25:07 leonardo kernel: [1938186.328379] Code: 04 85 f6 0f 84 5d 0=
1 00 00 8b 45 f0 89 f1 8d 14 30 89 55 f0 8b 13 e8 ff e8 ff ff 29 c6 29 f7 e=
b a1 89 f6 8d bc 27 00 00 00 00 <0f> 0b 8b 45 e4 31 db e8 d4 13 cf ff 8d 65=
 f4 89 d8 5b 5e 5f 5d c3
Jun 21 05:25:07 leonardo kernel: [1938186.328379] EAX: 00001000 EBX: ff1e31=
e1 ECX: 00000212 EDX: 80000039
Jun 21 05:25:07 leonardo kernel: [1938186.328379] ESI: f514dcb8 EDI: 000001=
26 EBP: d2985de4 ESP: d2985dc4
Jun 21 05:25:07 leonardo kernel: [1938186.328379] DS: 007b ES: 007b FS: 00d=
8 GS: 00e0 SS: 0068 EFLAGS: 00010213
Jun 21 05:25:07 leonardo kernel: [1938186.328379] CR0: 80050033 CR2: 004d6c=
cd CR3: 2e3b1cc0 CR4: 000006f0
Jun 21 05:25:07 leonardo kernel: [1938186.328379] Call Trace:
Jun 21 05:25:07 leonardo kernel: [1938186.328379]  ? generic_perform_write+=
0xa0/0x1a0
Jun 21 05:25:07 leonardo kernel: [1938186.328379]  generic_perform_write+0x=
c2/0x1a0
Jun 21 05:25:07 leonardo kernel: [1938186.328379]  ? call_rcu_sched+0x14/0x=
20
Jun 21 05:25:07 leonardo kernel: [1938186.328379]  __generic_file_write_ite=
r+0x183/0x1d0
Jun 21 05:25:07 leonardo kernel: [1938186.328379]  ext4_file_write_iter+0xb=
4/0x520 [ext4]
Jun 21 05:25:07 leonardo kernel: [1938186.328379]  new_sync_write+0xdf/0x160
Jun 21 05:25:07 leonardo kernel: [1938186.328379]  ? apparmor_file_permissi=
on+0x16/0x20
Jun 21 05:25:07 leonardo kernel: [1938186.328379]  ? ext4_file_mmap+0xa0/0x=
a0 [ext4]
Jun 21 05:25:07 leonardo kernel: [1938186.328379]  __vfs_write+0x37/0x50
Jun 21 05:25:07 leonardo kernel: [1938186.328379]  vfs_write+0x98/0x1b0
Jun 21 05:25:07 leonardo kernel: [1938186.328379]  ksys_write+0x49/0xb0
Jun 21 05:25:07 leonardo kernel: [1938186.328379]  sys_write+0x16/0x20
Jun 21 05:25:07 leonardo kernel: [1938186.328379]  do_fast_syscall_32+0x7e/=
0x1c0
Jun 21 05:25:07 leonardo kernel: [1938186.328379]  entry_SYSENTER_32+0x6b/0=
xbe
Jun 21 05:25:07 leonardo kernel: [1938186.328379] EIP: 0xb7f1ed39
Jun 21 05:25:07 leonardo kernel: [1938186.328379] Code: 08 8b 80 5c cd ff f=
f 85 d2 74 02 89 02 5d c3 8b 04 24 c3 8b 0c 24 c3 8b 1c 24 c3 8b 3c 24 c3 9=
0 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77=
 00 00 00 cd 80 90 8d 76
Jun 21 05:25:07 leonardo kernel: [1938186.328379] EAX: ffffffda EBX: 000000=
07 ECX: 0252a9c8 EDX: 000000bb
Jun 21 05:25:07 leonardo kernel: [1938186.328379] ESI: 02529dc0 EDI: 000000=
bb EBP: 0252a9c8 ESP: bfb1ead4
Jun 21 05:25:07 leonardo kernel: [1938186.328379] DS: 007b ES: 007b FS: 000=
0 GS: 0033 SS: 007b EFLAGS: 00000296
Jun 21 05:25:07 leonardo kernel: [1938186.328379] ---[ end trace c76fe0b987=
3e4613 ]---

--MP_/JOtty=tNM=EsoS93KPlhdc=--

--Sig_/gMFNIWEVCXqI/Tn.S_YZpks
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEv/2bXrNWp9EAWgjaFCJRCMHSVp8FAl0POx8ACgkQFCJRCMHS
Vp99xw/9GGtQrRIl4WvMmdBa7Fxan84Gj2RYohw3xEPWc+xCBzqfGsXHxcQJpED5
Q39gw8JhCd6lz2FlubiH1BVQRUBX1G/acwKIg+HxWTcq5ksbERoqBw9+2z70/2Ey
kjKIoCvDEkrVeHrNVoh1loFQoqNp4kFhjvU9iVB8NIJbz7tKwBw+d9lrGjE9lmG8
nF6JYevcQacMzBdqp0hOoeMZuI9+yFVSLgcbtVMAFVXCxrsoUEb5KYcBZLWBQO9z
f3WQVxQlAM8ZVDNya9PsPGqA0ihuzp2nV8T11pW5yqFkE6TzZd5VhRHiJzZV7zGd
i4nrRTPEXN4aH0e9exc1hUnfioaYxs9xEkjD/ZlPDf8vu14/B5by0VEjB+Tg+4rj
+V3rT0CoB2TJESbH+Pmkv+CTWMxPRlt4RsMy1kFquLN6Y5w/LZPC3BgJ9Ge7ilLQ
0dYm4R3Y2KmnpnUyJTHJEaRVXyfDJAOQc/gMlCXqk4zPfvOngqeagyWPxZTYsEte
+C8Xs60xGOXtivJ/rNzIwo+XhU+DR2ZwG7oibA6kS1Vl3IoJzZV5N6uD1k7eLDud
Zxwrxa74Tu394L+r0u06PCj2acHX2c9FZG5b0oDHin1/cycGXkphBVwTomB4pa6+
TnigpHChJOoQDPJlTimpTtOYSOSAkIWGKr/+Tm8RSLPj6Pkb7yU=
=opeI
-----END PGP SIGNATURE-----

--Sig_/gMFNIWEVCXqI/Tn.S_YZpks--
